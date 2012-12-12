package org.kisobran.service
{
	import com.dborisenko.api.twitter.TwitterAPI;
	import com.dborisenko.api.twitter.commands.search.Search;
	import com.dborisenko.api.twitter.data.TwitterStatus;
	import com.dborisenko.api.twitter.events.TwitterEvent;
	import com.dborisenko.api.twitter.net.TwitterOperation;
	import com.dborisenko.api.twitter.oauth.events.OAuthTwitterEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.collections.ArrayList;
	
	import org.kisobran.track.event.TwitEvent;

	public class TwitterSearchService extends EventDispatcher
	{
		private var twitterApi:TwitterAPI = new TwitterAPI();
		private var searchOperation:TwitterOperation;
		private var _searchTerm:String;
		private var searchTimer:Timer;
		
		public function TwitterSearchService(term:String)
		{
			_searchTerm = term;
			searchOperation = new Search(_searchTerm);
			twitterApi.connection.addEventListener(OAuthTwitterEvent.REQUEST_TOKEN_RECEIVED, handleRequestTokenReceived);
			twitterApi.connection.addEventListener(OAuthTwitterEvent.REQUEST_TOKEN_ERROR, handleRequestTokenError);
			twitterApi.connection.addEventListener(OAuthTwitterEvent.ACCESS_TOKEN_ERROR, handleAccessTokenError);
			twitterApi.connection.addEventListener(OAuthTwitterEvent.AUTHORIZED, handleAuthorized);
			twitterApi.connection.authorize(Config.CONSUMER_KEY, Config.CONSUMER_SECRET);
			searchOperation.addEventListener(com.dborisenko.api.twitter.events.TwitterEvent.COMPLETE, searchHandler);
			initSearchTimer();
		}
		
		private function initSearchTimer():void {
			searchTimer = new Timer(Config.SEARCH_INTERVAL);
			searchTimer.addEventListener(TimerEvent.TIMER, timer_timer);
			searchTimer.start();
		}
		
		private function timer_timer(evt:TimerEvent):void {
			doSearch();
		}
		
		protected function handleRequestTokenReceived(event:OAuthTwitterEvent):void {
			doSearch();
		}
		
		protected function handleRequestTokenError(event:OAuthTwitterEvent):void {
			trace("Request token error");
		}
		
		protected function handleAccessTokenError(event:OAuthTwitterEvent):void {
			trace("Access token error");
		}
		
		protected function handleAuthorized(event:OAuthTwitterEvent):void {
			trace("Authorized");
		}
		
		public function doSearch():void {
			twitterApi.post(searchOperation);
		}
		
		private function searchHandler(evt:TwitterEvent):void {
			var newTweets:ArrayList = new ArrayList();
			for each(var status:TwitterStatus in evt.data.results) {
				if (status.text.search("#"+_searchTerm) >= 0) {
					newTweets.addItem(status.text);
				}
			}
			if(newTweets.length > 0) {
					dispatchEvent(new TwitEvent(TwitEvent.TWITS_FOUNDED, newTweets));
			}
		}
		
	}
}
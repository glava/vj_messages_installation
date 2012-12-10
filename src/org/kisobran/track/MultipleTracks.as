package org.kisobran.track
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.core.mx_internal;
	import mx.events.TweenEvent;
	
	import org.kisobran.service.TwitterSearchService;
	import org.kisobran.track.event.TrackEvent;
	import org.kisobran.track.event.TwitEvent;
	
	import spark.components.SkinnableContainer;
	import spark.effects.Move;
	
	
	public class MultipleTracks extends SkinnableContainer
	{
		private static const NUMBER_OF_MESSAGES:int = 5;
		
		[SkinPart(required="true")]
		public var trackOne:SingleTrack;
		
		[SkinPart(required="true")]
		public var trackTwo:SingleTrack;
		
		[SkinPart(required="true")]
		public var trackThree:SingleTrack;
		
		public var _messages:ArrayList = new ArrayList();
		public var _twitterService:TwitterSearchService = new TwitterSearchService("sadpanda");
		public var lastUpdateTrack:int = 0;
		public var _useTwitter:Boolean = false;
		
		public function MultipleTracks()
		{
			super();
			for (var i:int = 0; i < NUMBER_OF_MESSAGES; i++) 
			{
				_messages.addItem("");
			}
			this.addEventListener(TrackEvent.START_IN_NEW_LINE, onStartOnNewLine);
			_twitterService.addEventListener(TwitEvent.TWITS_FOUNDED, newTwitsFounded);
		}
		
		protected override function partAdded(partName:String, instance:Object):void {
			super.partAdded(partName, instance);
		}
		
		private function onStartOnNewLine(evt:TrackEvent):void {
			switch(evt.target) {
				case trackOne: trackTwo.prepareLabels(evt.messages); trackTwo.startMoving(); break;
				case trackTwo: trackThree.prepareLabels(evt.messages); trackThree.startMoving(); break;
				//case trackThree:  trackOne.start(); break;
			}
		}
		
		public function startTracks():void {
			trackOne.prepareLabels(_messages);
		}
		
		public function updateMessages(newMessages:ArrayList):void {
			var size:int = newMessages.length > NUMBER_OF_MESSAGES ? NUMBER_OF_MESSAGES : newMessages.length;
			_messages.removeAll();
			for (var i:int = 0; i < size; i++) {
				_messages.addItem(newMessages.getItemAt(i));
			}
			trackOne.prepareLabels(_messages);
		}
		
		public function updateSingleTrack(message:String):void {
			updateMessages(prepareNewListForSingleTrack(message, lastUpdateTrack));
		}
		
		//generates new list using single text and old list
		private function prepareNewListForSingleTrack(text:String, lastUpdateTrack:int):ArrayList {
			var arrayList:ArrayList = new ArrayList();
			for (var i:int = 0; i < _messages.length; i++) 
			{
				arrayList.addItem(_messages.getItemAt(i));	
			}
			
			arrayList.addItemAt(text, lastUpdateTrack);
			if(lastUpdateTrack == (NUMBER_OF_MESSAGES - 1)){
				lastUpdateTrack = 0;
			} else {
				lastUpdateTrack + 1;
			}
			return arrayList;
		}
		
		public function newTwitsFounded(evt:TwitEvent):void {
			if(_useTwitter) {
				var arr:ArrayList = evt.twits;
				if(arr.length < NUMBER_OF_MESSAGES) {
					for(var i:int; i< NUMBER_OF_MESSAGES - arr.length; i++) {
						arr.addItem("");
					}
				}
				updateMessages(arr);
			}
		}
		
		public function enableTwitterService(useTwitter:Boolean):void {
			_useTwitter = useTwitter;
			if(_useTwitter) {
				_twitterService.doSearch();
			}
		}
	}
}
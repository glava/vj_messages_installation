package org.kisobran.service
{
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayList;
	
	import org.kisobran.track.event.TwitterEvent;

	public class TwitterService extends EventDispatcher
	{
		public function TwitterService()
		{
			
		}
		
		public function simulateNewTweets():void {
			var messages:ArrayList = new ArrayList();
			messages.addItem("Novo 0 ");
			messages.addItem("Magicno 1 ");
			messages.addItem("Slabo 2 ");
			messages.addItem("Nisam znao 3 ");
			messages.addItem("Ali hteo sam 4 ");
			
			dispatchEvent(new TwitterEvent(TwitterEvent.NEW_TWITS_FOUNDED, messages));
		}
	}
}
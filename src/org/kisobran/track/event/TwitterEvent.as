package org.kisobran.track.event
{
	import flash.events.Event;
	
	import mx.collections.ArrayList;
	
	public class TwitterEvent extends Event
	{
		public static const NEW_TWITS_FOUNDED:String = "newTwitsFounded";
		
		private var _twits:ArrayList;
		
		public function TwitterEvent(type:String, twitts:ArrayList, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_twits = twitts;
		}

		public function get twits():ArrayList
		{
			return _twits;
		}

		public function set twits(value:ArrayList):void
		{
			_twits = value;
		}

	}
}
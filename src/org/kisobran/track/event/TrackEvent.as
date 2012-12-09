package org.kisobran.track.event
{
	import flash.events.Event;
	
	import mx.collections.ArrayList;
	
	public class TrackEvent extends Event
	{
		public static const START_IN_NEW_LINE:String = "startInNewLine";
		public var messages:ArrayList;
		public function TrackEvent(type:String, messages:ArrayList)
		{
			super(type, true, false);
			this.messages = messages;
		}
	}
}
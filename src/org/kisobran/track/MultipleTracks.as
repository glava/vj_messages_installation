package org.kisobran.track
{
	import flash.events.Event;
	
	import mx.collections.ArrayList;
	import mx.core.mx_internal;
	
	import org.kisobran.track.event.TrackEvent;
	
	import spark.components.SkinnableContainer;
	import spark.effects.Move;
	
	
	public class MultipleTracks extends SkinnableContainer
	{
		[SkinPart(required="true")]
		public var trackOne:SingleTrack;
		
		[SkinPart(required="true")]
		public var trackTwo:SingleTrack;
		
		[SkinPart(required="true")]
		public var trackThree:SingleTrack;
		
		public var messages:ArrayList = new ArrayList();
		
		public function MultipleTracks()
		{
			super();
			messages.addItem("HitTest0 class is as close as possible to the example.  ");
			messages.addItem("HitTest1 class is as close as possible to the example.  ");
			messages.addItem("HitTest2 class is as close as possible to the example.  ");
			messages.addItem("HitTest3 class is as close as possible to the example.  ");
			messages.addItem("HitTclass4 is as close as possible to the example.  ");
			
			this.addEventListener(TrackEvent.START_IN_NEW_LINE, onStartOnNewLine);
		}
		
		protected override function partAdded(partName:String, instance:Object):void {
			super.partAdded(partName, instance);
			switch(instance) {
				case trackOne: trackOne.prepareLabels(messages); break;
			}
		}
		
		private function onStartOnNewLine(evt:TrackEvent):void {
			switch(evt.target) {
				case trackOne: trackTwo.prepareLabels(evt.messages); trackTwo.start(); break;
				case trackTwo: trackThree.prepareLabels(evt.messages); trackThree.start(); break;
				//case trackThree:  trackOne.start(); break;
			}
		}
		
		public function startTracks():void {
			trackOne.start();
		}
		
		public function updateMessages(messages:ArrayList):void {
			trackOne.prepareLabels(messages);
		}
	}
}
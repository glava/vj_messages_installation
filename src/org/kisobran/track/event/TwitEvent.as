package org.kisobran.track.event {
    import flash.events.Event;

    import mx.collections.ArrayList;

    public class TwitEvent extends Event {
        public static const TWITS_FOUNDED:String="twitsFounded";

        private var _twits:ArrayList;

        public function TwitEvent(type:String, twitts:ArrayList, bubbles:Boolean=false, cancelable:Boolean=false) {
            super(type, bubbles, cancelable);
            _twits=twitts;
        }

        public function get twits():ArrayList {
            return _twits;
        }

        public function set twits(value:ArrayList):void {
            _twits=value;
        }

    }
}

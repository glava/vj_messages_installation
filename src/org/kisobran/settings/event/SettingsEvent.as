package org.kisobran.settings.event {
    import flash.events.Event;

    public class SettingsEvent extends Event {
        public static const USE_TWITTER:String="use.twitter";
        public static const UPDATE_SINGLE_MESSAGE:String="update.single.message";
        public static const UPDATE_MUTLIIPLE_MESSAGE:String="update.multiple.message";
        public static const SPEED_CHANGE:String="speed.change";
        public static const START:String="wall.start";

        public var data:Object;

        public function SettingsEvent(type:String, data:Object, bubbles:Boolean=false, cancelable:Boolean=false) {
            super(type, bubbles, cancelable);
            this.data=data;
        }
    }
}

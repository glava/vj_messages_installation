package org.kisobran.terminal.event {
    import flash.events.Event;

    public class TerminalEvent extends Event {

        public static const UPDATE_SINGLE_MESSAGE:String="update.single.message.terminal";
        public var message:String;

        public function TerminalEvent(type:String, message:String, bubbles:Boolean=false, cancelable:Boolean=false) {
            super(type, bubbles, cancelable);
            this.message=message;
        }
    }
}

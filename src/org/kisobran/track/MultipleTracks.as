package org.kisobran.track {
    import flash.events.Event;

    import mx.collections.ArrayCollection;
    import mx.collections.ArrayList;
    import mx.core.mx_internal;
    import mx.events.TweenEvent;

    import org.kisobran.file.FileWriter;
    import org.kisobran.service.TwitterSearchService;
    import org.kisobran.track.event.TrackEvent;
    import org.kisobran.track.event.TwitEvent;
    import org.kisobran.util.Util;

    import spark.components.SkinnableContainer;
    import spark.effects.Move;


    public class MultipleTracks extends SkinnableContainer {
        [SkinPart(required="true")]
        public var trackOne:SingleTrack;

        [SkinPart(required="true")]
        public var trackTwo:SingleTrack;

        [SkinPart(required="true")]
        public var trackThree:SingleTrack;

        public var _messages:ArrayList=new ArrayList();
        private var _backupMessages:ArrayList;

        public var _twitterService:TwitterSearchService=new TwitterSearchService("kisobran");
        public var lastUpdateTrack:int=0;
        public var _useTwitter:Boolean=false;

        public function MultipleTracks() {
            super();
            for (var i:int=0; i < Config.NUMBER_OF_MESSAGES; i++) {
                _messages.addItem("");
            }
            this.addEventListener(TrackEvent.START_IN_NEW_LINE, onStartOnNewLine);
            _twitterService.addEventListener(TwitEvent.TWITS_FOUNDED, newTwitsFounded);
            _backupMessages=new ArrayList();
        }

        protected override function partAdded(partName:String, instance:Object):void {
            super.partAdded(partName, instance);
        }

        private function onStartOnNewLine(evt:TrackEvent):void {
            switch (evt.target) {
                case trackOne:
                    trackTwo.updateLabels(evt.messages);
                    trackTwo.startMoving();
                    break;
                case trackTwo:
                    trackThree.updateLabels(evt.messages);
                    trackThree.startMoving();
                    break;
            }
        }

        public function startTracks():void {
            trackOne.updateLabels(_messages);
        }

        public function updateMessages(newMessages:ArrayList):void {
            var size:int=newMessages.length > Config.NUMBER_OF_MESSAGES ? Config.NUMBER_OF_MESSAGES : newMessages.length;
            _messages.removeAll();
            for (var i:int=0; i < size; i++) {
                _messages.addItem(newMessages.getItemAt(i));
            }
            trackOne.updateLabels(_messages);
        }

        public function updateSingleTrack(message:String):void {
            _backupMessages.addItem(message);
            updateMessages(prepareNewListForSingleTrack(message, lastUpdateTrack));
            if (_backupMessages.length > 5) {
                backupMessages();
            }
        }

        //generates new list using single text and old list
        private function prepareNewListForSingleTrack(text:String, lastUpdateTrack:int):ArrayList {
            var arrayList:ArrayList=new ArrayList();
            for (var i:int=0; i < _messages.length; i++) {
                arrayList.addItem(_messages.getItemAt(i));
            }

            arrayList.addItemAt(text, Util.incrementInMod(trackOne.currentlyVisibile + 1, Config.NUMBER_OF_MESSAGES));
            return arrayList;
        }

        public function newTwitsFounded(evt:TwitEvent):void {
            if (_useTwitter) {
                var arr:ArrayList=evt.twits;
                if (arr.length < Config.NUMBER_OF_MESSAGES) {
                    for (var i:int; i < Config.NUMBER_OF_MESSAGES - arr.length; i++) {
                        arr.addItem("");
                    }
                }
                updateMessages(arr);
            }
        }

        public function changeSpeed(value:int):void {
            trackOne.speed=value;
            trackTwo.speed=value;
            trackThree.speed=value;
        }

        public function enableTwitterService(useTwitter:Boolean):void {
            _useTwitter=useTwitter;
            if (_useTwitter) {
                _twitterService.doSearch();
            }
        }

        public function backupMessages():void {
            FileWriter.getFileWritter().writeMessages(_backupMessages);
            _backupMessages.removeAll();
        }
    }
}
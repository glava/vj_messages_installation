package org.kisobran.file {
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;

    import mx.collections.ArrayList;

    public class FileWriter {
        private var file:File;

        private static var fileWriter:FileWriter;

        public function FileWriter() {
            file=File.desktopDirectory.resolvePath("vj_messages.txt");
        }

        public function writeMessages(messages:ArrayList):void {
            var fs:FileStream=new FileStream();
            fs.open(file, FileMode.APPEND);
            for (var i:int=0; i < messages.length; i++) {
                fs.writeUTFBytes((messages.getItemAt(i) as String) + File.lineEnding);
            }
            fs.close();

        }

        public static function getFileWritter():FileWriter {
            if (fileWriter == null) {
                fileWriter=new FileWriter();
            }
            return fileWriter;
        }
    }
}
package bmfontrenderer
{
    import flash.display.BitmapData;

    public class BMFont
    {
        public var glyphMap:Array = new Array();
        public var sheets:Array = new Array();
        
        public function addSheet(id:int, bits:BitmapData):void
        {
            if(sheets[id] != null)
                throw new Error("Overwriting sheet!");
            sheets[id] = bits;            
        }
        
        public function parseFont(fontDesc:String):void
        {
            
            var fontLines:Array = fontDesc.split("\n");
            
            for(var i:int=0; i<fontLines.length; i++)
            {
                // Lines can be one of:
                //  info
                //  page
                //  chars
                //  char

                var fontLine:Array = (fontLines[i] as String).split(" ");
                var keyWord:String = (fontLine[0] as String).toLowerCase();
                
                if(keyWord == "char")
                {
                    parseChar(fontLine);
                    continue;
                }

                if(keyWord == "info")
                {
                    // Ignore.
                    continue;
                }
                
                if(keyWord == "page")
                {
                    // Ignore.
                    continue;
                }
                
                if(keyWord == "chars")
                {
                    // Ignore.
                    continue;
                }
            }
        }
        
        public function parseChar(charLine:Array):void
        {
            var g:BMFontGlyph = new BMFontGlyph();
            
            for(var i:int=1; i<charLine.length; i++)
            {
                // Parse to key value.
                var charEntry:Array = (charLine[i] as String).split("=");
                if(charEntry.length != 2)
                    continue;
                
                var charKey:String = charEntry[0];
                var charVal:String = charEntry[1];
                
                // Assign to glyph.
                if(g.hasOwnProperty(charKey))
                    g[charKey] = charVal;
            }
            
            glyphMap[g.id] = g;
        }
    }
}
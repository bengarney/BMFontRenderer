package bmfontrenderer
{
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    /**
     * Represents a bitmapped font which can be drawn to a BitmapData.
     * 
     * Uses BMFont data as generated by BMFont (http://www.angelcode.com/products/bmfont/, win32) or
     * Hiero (http://slick.cokeandcode.com/demos/hiero.jnlp, cross platform).
     * 
     * Currently does not support:
     *      - Kerning.
     *      - Channel packing (currently blits all channels).
     *      - Line breaks/text alignment.
     *      - Unicode outside of the Basic Multilingual Plane. 
     */
    public class BMFont
    {
        public var glyphMap:Array = new Array();
        public var sheets:Array = new Array();

        /**
         * Utility function to return a copy of a BitmapData flipped vertically. 
         */
        public static function flipVert(bd:BitmapData):BitmapData
        {
            var mat:Matrix = new Matrix();
            mat.d = -1;
            mat.ty = bd.height;
            
            var flip:BitmapData = new BitmapData(bd.width, bd.height, bd.transparent, 0x0);
            flip.draw(bd, mat);

            return flip;
        }
        
        /**
         * Draw a string to a BitmapData.
         *  
         * @param target BitmapData to draw to.
         * @param startX X pixel position to start drawing at.
         * @param startY Y pixel position to start drawing at.
         * @param text String to draw.
         * 
         */
        public function drawString(target:BitmapData, startX:int, startY:int, text:String):void
        {
            var curX:int = startX;
            var curY:int = startY;
            
			var sourceRectangle:Rectangle = new Rectangle();
			var destinationPoint:Point = new Point();
            
            // Walk the string.
            for(var curCharIdx:int = 0; curCharIdx < text.length; curCharIdx++)
            {
                // Identify the glyph.
                var curChar:int = text.charCodeAt(curCharIdx);
                var curGlyph:BMGlyph = glyphMap[curChar];
				var sourceBd:BitmapData = sheets[curGlyph.page];
			
				// skip missing glyphs.
                if(!curGlyph || !sourceBd)
                    continue;

				// set draw parameters
				sourceRectangle.x = curGlyph.x;
				sourceRectangle.y = curGlyph.y;
				sourceRectangle.width = curGlyph.width;
				sourceRectangle.height = curGlyph.height;

				destinationPoint.x = curX + curGlyph.xoffset;
				destinationPoint.y = curY + curGlyph.yoffset;

                // Draw the glyph.
                target.copyPixels(sourceBd, sourceRectangle, destinationPoint, null, null, true);

                // Update cursor position
                curX += curGlyph.xadvance;
            }
        }
        
        /**
         * Add a bitmap sheet.
         */
        public function addSheet(id:int, bits:BitmapData, isFlipped:Boolean = false):void
        {
            if(sheets[id] != null)
                throw new Error("Overwriting sheet!");

			if (isFlipped)
            	sheets[id] = flipVert(bits);
			else
				sheets[id] = bits;
        }
        
        /**
         * Parse a BMFont textual font description.
         */
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
                //  common

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
        
        /**
         * Helper function to parse and register a glyph from a BMFont 
         * description..
         */
        protected function parseChar(charLine:Array):void
        {
            var g:BMGlyph = new BMGlyph();
            
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
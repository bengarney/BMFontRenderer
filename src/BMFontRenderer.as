package
{
    import bmfontrenderer.BMFont;
    
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.utils.ByteArray;
        
    [SWF(backgroundColor="0x1234567")]
    public class BMFontRenderer extends Sprite
    {
        [Embed(source="arial_32.fnt", mimeType="application/octet-stream")]
        public var fontData:Class;
 
        [Embed(source="arial_32.png")]
        public var fontSheet:Class;

        public function BMFontRenderer()
        {
            // Don't scale.
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            
            // Get the font data and pass it to the BMFont.
            var fontBits:ByteArray = new fontData();
            var font:String = fontBits.readUTFBytes(fontBits.length);
            
            var bmfont:BMFont = new BMFont();
            bmfont.parseFont(font);
            
            trace("Parsed " + bmfont.glyphMap.length + " glyphs");
            
            bmfont.addSheet(0, (new fontSheet()).bitmapData, true);
            
            // OK, draw some fonts!
            var out:BitmapData = new BitmapData(200, 100, true, 0x0);
            bmfont.drawString(out, 0, 0, "Hello, world!");
            
            var outb:Bitmap = new Bitmap(out);
            addChild(outb);
        }
    }
}
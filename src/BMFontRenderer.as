package
{
    import bmfontrenderer.BMFont;
    
    import flash.display.Sprite;
    import flash.utils.ByteArray;
    
    public class BMFontRenderer extends Sprite
    {
        [Embed(source="../../GruntsSkirmish.git/assets/fonts/arial_32.fnt", mimeType="application/octet-stream")]
        public var fontData:Class;
 
        public function BMFontRenderer()
        {
            var fontBits:ByteArray = new fontData();
            var font:String = fontBits.readUTFBytes(fontBits.length);
            
            var bmfont:BMFont = new BMFont();
            bmfont.parseFont(font);
            
            trace("Parsed " + bmfont.glyphMap.length + " glyphs");
        }
    }
}
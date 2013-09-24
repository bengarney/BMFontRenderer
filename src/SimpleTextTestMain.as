package {
import bmfontrenderer.BMFont;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.utils.ByteArray;

[SWF(backgroundColor="0x1234567")]
public class SimpleTextTestMain extends Sprite {
	[Embed(source="testFont.fnt", mimeType="application/octet-stream")]
	public var fontData:Class;

	[Embed(source="testFont.png")]
	public var fontSheet:Class;

	public function SimpleTextTestMain() {
		// Don't scale.
		stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;

		// Get the font data and pass it to the BMFont.
		var fontBits:ByteArray = new fontData();
		var font:String = fontBits.readUTFBytes(fontBits.length);

		BMFont.parseFont(font);

		//trace("Parsed " + bmfont.glyphMap.length + " glyphs");

		BMFont.addSheet(0, (new fontSheet()).bitmapData);

		// OK, draw some fonts!
		var out:BitmapData = new BitmapData(600, 300, true, 0x0);
		BMFont.drawString(out, 0, 0, "Hello world!!");


		var outb:Bitmap = new Bitmap(out);
		addChild(outb);
	}
}
}
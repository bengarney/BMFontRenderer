package {
import bitmapFontRenderer.BitmapFontRender;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.utils.ByteArray;

[SWF(backgroundColor="0x1234567")]
public class BMFontRenderer extends Sprite {

	[Embed(source="arial_32.fnt", mimeType="application/octet-stream")]
	public var fontData:Class;

	[Embed(source="arial_32.png")]
	public var fontSheet:Class;

	public function BMFontRenderer() {
		// Don't scale.
		stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;

		// Get the font data and pass it to the BMFont.
		var fontBits:ByteArray = new fontData();
		var font:String = fontBits.readUTFBytes(fontBits.length);

		BitmapFontRender.addFont(0, font, (new fontSheet()).bitmapData);

		// OK, draw some fonts!
//		var out:BitmapData = new BitmapData(200, 100, true, 0x0);
//		BMFont.drawString("Hello, world!", out);

		var out2:BitmapData  = BitmapFontRender.createText("Hello, world!");

		var outb:Bitmap = new Bitmap(out2);
		addChild(outb);
	}
}
}
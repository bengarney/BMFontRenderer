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

	[Embed(source="test2Font.fnt", mimeType="application/octet-stream")]
	public var fontData2:Class;

	[Embed(source="test2Font.png")]
	public var fontSheet2:Class;


	private static const TEST_FONT:String = "testFont";

	private static const TEST_FONT_2:String = "testFont2";

	public function SimpleTextTestMain() {
		// Don't scale.
		stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;

		// Get the font data and pass it to the BMFont.
		var fontBits:ByteArray = new fontData();
		var font:String = fontBits.readUTFBytes(fontBits.length);

		BMFont.addFont(TEST_FONT, font, [(new fontSheet()).bitmapData]);

		// Get the font data and pass it to the BMFont.
		fontBits = new fontData2();
		font = fontBits.readUTFBytes(fontBits.length);

		BMFont.addFont(TEST_FONT_2, font, [(new fontSheet2()).bitmapData]);

		// OK, draw some fonts!
		//var out:BitmapData = new BitmapData(600, 300, true, 0x0);
		//BMFont.drawString("Hello world!!", out);

		var out:BitmapData = BMFont.createText("Hello world!! 123 123 123");
		var outb:Bitmap = new Bitmap(out);
		addChild(outb);

		var out2:BitmapData = BMFont.createText("Hello world!! 123 123 123", TEST_FONT_2);
		var outb2:Bitmap = new Bitmap(out2);
		addChild(outb2);
		outb2.y = 100;



		var border:Sprite = new Sprite();
		border.graphics.lineStyle(0.1, 0);
		border.graphics.drawRect(0, 0, out2.width, out2.height);
		addChild(border);
	}
}
}
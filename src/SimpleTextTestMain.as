package {
import bmfontrenderer.BitmapFont;
import bmfontrenderer.BitmapTextAlign;

import com.bit101.components.ComboBox;
import com.bit101.components.Text;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
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


	private var outputBd:BitmapData;
	private var output:Bitmap;

	private var border:Sprite;

	private var fontNames:ComboBox;
	private var testText:Text;
	private var textAlignment:ComboBox;

	private static const TEST_FONT:String = "testFont";

	private static const TEST_FONT_2:String = "testFont2";

	public function SimpleTextTestMain() {
		// Don't scale.
		stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;

		// Get the font data and pass it to the BMFont.
		var fontBits:ByteArray = new fontData();
		var font:String = fontBits.readUTFBytes(fontBits.length);

		BitmapFont.addFont(TEST_FONT, font, [(new fontSheet()).bitmapData]);

		// Get the font data and pass it to the BMFont.
		fontBits = new fontData2();
		font = fontBits.readUTFBytes(fontBits.length);

		BitmapFont.addFont(TEST_FONT_2, font, [(new fontSheet2()).bitmapData]);

		// OK, draw some fonts!
		//var out:BitmapData = new BitmapData(600, 300, true, 0x0);
		//BMFont.drawString("Hello world!!", out);

//		var out2:BitmapData = BitmapFont.createText("Hello world!! 123 123 123", TEST_FONT_2);
//		var outb2:Bitmap = new Bitmap(out2);
//		addChild(outb2);
//		outb2.x = 200;
//		outb2.y = 100;

		border = new Sprite();
		border.x = 220;
		border.y = 20;
		addChild(border);

		fontNames = new ComboBox(this, 5, 5);

		fontNames.addItem(TEST_FONT);
		fontNames.addItem(TEST_FONT_2);
		fontNames.selectedIndex = 0;
		fontNames.addEventListener(Event.SELECT, handleTextInput);

		testText = new Text(this, 5, 30, "Hello!");
		testText.addEventListener(Event.CHANGE, handleTextInput);

		textAlignment = new ComboBox(this, 5, 150);

		textAlignment.addItem(BitmapTextAlign.LEFT);
		textAlignment.addItem(BitmapTextAlign.CENTER);
		textAlignment.addItem(BitmapTextAlign.RIGHT);

		textAlignment.selectedIndex = 0;
		textAlignment.addEventListener(Event.SELECT, handleTextInput);

		handleTextInput();

	}

	private function handleTextInput(event:Event = null):void {

		if (output) {
			removeChild(output);
		}

		outputBd = BitmapFont.createText(testText.text, String(fontNames.selectedItem), 0, 0, String(textAlignment.selectedItem));
		output = new Bitmap(outputBd);
		addChild(output);
		output.x = 220;
		output.y = 20;

		border.graphics.clear();
		border.graphics.lineStyle(0.1, 0);
		border.graphics.drawRect(0, 0, outputBd.width, outputBd.height);
	}
}
}
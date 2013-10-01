package {
import bmfontrenderer.BitmapBlockVO;
import bmfontrenderer.BitmapFont;

import com.bit101.components.ComboBox;
import com.bit101.components.Label;
import com.bit101.components.NumericStepper;
import com.bit101.components.Text;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.utils.ByteArray;

[SWF(backgroundColor="0x888888")]
public class SimpleTextTestMain extends Sprite {

	[Embed(source="testFont.fnt", mimeType="application/octet-stream")]
	public var fontData:Class;

	[Embed(source="testFont.png")]
	public var fontSheet:Class;

	[Embed(source="test2Font.fnt", mimeType="application/octet-stream")]
	public var fontData2:Class;

	[Embed(source="test2Font.png")]
	public var fontSheet2:Class;

	////////////////
	private const TEST_FONT:String = "testFont";
	private const TEST_FONT_2:String = "testFont2";

	////////////////

	private var outputBd:BitmapData;
	private var output:Bitmap;

	private var border:Sprite;

	private var offsetXText:NumericStepper;
	private var offsetYText:NumericStepper;

	private var fontNames:ComboBox;
	private var testText:Text;

	private var minWidthText:NumericStepper;
	private var minHeightText:NumericStepper;
	private var maxWidthText:NumericStepper;
	private var maxHeightText:NumericStepper;

	private var textAlignment:ComboBox;

	public function SimpleTextTestMain() {
		// Don't scale.
		stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;

		///////////////////////

		var fontBits:ByteArray = new fontData();
		var font:String = fontBits.readUTFBytes(fontBits.length);
		BitmapFont.addFont(TEST_FONT, font, [(new fontSheet()).bitmapData]);

		///////////////////////

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

		/////////////////////////////

		new Label(this, 5, 5, "Font:");

		fontNames = new ComboBox(this, 40, 5);
		fontNames.addItem(TEST_FONT);
		fontNames.addItem(TEST_FONT_2);
		fontNames.selectedIndex = 0;
		fontNames.addEventListener(Event.SELECT, handleTextInput);

		testText = new Text(this, 5, 30, "Hello!");
		testText.addEventListener(Event.CHANGE, handleTextInput);

		/////////////////////////////

		new Label(this, 5, 140, "Offset position [OPTIONAL]");

		offsetXText = new NumericStepper(this, 5, 160);
		offsetXText.addEventListener(Event.CHANGE, handleTextInput);
		offsetXText.value = 0;
		offsetXText.step = 10;
		offsetYText = new NumericStepper(this, 90, 160);
		offsetYText.addEventListener(Event.CHANGE, handleTextInput);
		offsetYText.value = 0;
		offsetYText.step = 10;

		/////////////////////////////

		new Label(this, 5, 185, "Text alignment:");
		textAlignment = new ComboBox(this, 5, 200);

		textAlignment.addItem(BitmapFont.LEFT);
		textAlignment.addItem(BitmapFont.CENTER);
		textAlignment.addItem(BitmapFont.RIGHT);

		textAlignment.selectedIndex = 0;
		textAlignment.addEventListener(Event.SELECT, handleTextInput);

		/////////////////////////////

		new Label(this, 5, 230, "Min size [OPTIONAL]");

		minWidthText = new NumericStepper(this, 5, 250);
		minWidthText.addEventListener(Event.CHANGE, handleTextInput);
		minWidthText.value = 0;
		minWidthText.step = 10;
		minHeightText = new NumericStepper(this, 90, 250);
		minHeightText.addEventListener(Event.CHANGE, handleTextInput);
		minHeightText.value = 0;
		minHeightText.step = 10;

		/////////////////////////////

		new Label(this, 5, 270, "Max size [OPTIONAL]");

		maxWidthText = new NumericStepper(this, 5, 290);
		maxWidthText.addEventListener(Event.CHANGE, handleTextInput);
		maxWidthText.value = 0;
		maxWidthText.step = 10;
		maxHeightText = new NumericStepper(this, 90, 290);
		maxHeightText.addEventListener(Event.CHANGE, handleTextInput);
		maxHeightText.value = 0;
		maxHeightText.step = 10;

		/////////////////////////////

		handleTextInput();
	}

	private function handleTextInput(event:Event = null):void {

		if (output) {
			removeChild(output);
		}

		outputBd = BitmapFont.drawString( //
				testText.text, null,  //
				String(fontNames.selectedItem), //
				offsetXText.value, offsetYText.value,  //
				String(textAlignment.selectedItem), //
				minWidthText.value, minHeightText.value, //
				maxWidthText.value, maxHeightText.value //
		);
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
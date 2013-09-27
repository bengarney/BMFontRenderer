package {
import bmfontrenderer.BitmapFont;

import flash.display.BitmapData;
import flash.display.Sprite;

public class NotExistingFontTestMain extends Sprite {
	public function NotExistingFontTestMain() {

		var out:BitmapData = BitmapFont.createText("Hello world!! 123 123 123");

	}
}
}

package {
import bitmapFontRenderer.BitmapFontRender;

import flash.display.BitmapData;
import flash.display.Sprite;

public class NotExistingFontTestMain extends Sprite {
	public function NotExistingFontTestMain() {

		var out:BitmapData = BitmapFontRender.renderText("Hello world!! 123 123 123");

	}
}
}

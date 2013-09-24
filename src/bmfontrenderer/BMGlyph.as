package bmfontrenderer {
/**
 * Represents a single glyph from a BMFont. A glyph is a character.
 *
 * Note that field names must map identically to the strings in the .fnt
 * file, as we directly assign based on key.
 */
public class BMGlyph {
	public var id:int;
	public var x:int, y:int;
	public var width:int, height:int;
	public var xoffset:int, yoffset:int;
	public var xadvance:int;
	public var page:int, chnl:int;
}
}
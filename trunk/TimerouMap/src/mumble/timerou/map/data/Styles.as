package mumble.timerou.map.data
{
	import flash.geom.Point;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class Styles
	{
		// Animated Letter
		public static const LETTER_FONT:String = "Lucida Sans Unicode";
		public static const LETTER_SIZE:int = 28;
		public static const LETTER_COLOR:Object = 0xBB0E0E; 
		
		// YearControl Action Description
		public static const ACTIONDESCRIPTION_FONT:String = "Lucida Sans Unicode";
		public static const ACTIONDESCRIPTION_SIZE:int = 14;
		public static const ACTIONDESCRIPTION_COLOR:Object = 0x2E2E2E;
		
		public static function getAnimatedLetterTextFormat():TextFormat 
		{
			var textFormat:TextFormat = new TextFormat();
			textFormat.font = LETTER_FONT;
			textFormat.size = LETTER_SIZE;
			textFormat.color = LETTER_COLOR;
			
			return textFormat;
		}		
		
		public static function getActionDescriptionTextFormat():TextFormat 
		{
			var textFormat:TextFormat = new TextFormat();
			textFormat.font = ACTIONDESCRIPTION_FONT;
			textFormat.size = ACTIONDESCRIPTION_SIZE;
			textFormat.color = ACTIONDESCRIPTION_COLOR;			
			
			return textFormat;
		}
	}
}
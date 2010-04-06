package mumble.timerou.timebar.data
{
	import flash.geom.Point;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class Styles
	{
		public static const elementsMargin:Number = 10;
		public static const verticalMargin:Number = 5;
		public static const yearMediaLineThickness:Number = 3;
		public static const yearMediaSize:Point = new Point(77, 55);
		public static const yearMediaLineColor:uint = 0xE0E0E0;
		public static const yearMediaPointerSize:Point = new Point(10, 10);
		public static const yearMediaMargin:Number = 10;
		public static const cornerSize:Number = 20;
		public static const barColor:uint = 0xE67F23;
		public static const barThickness:Number = 3;
		public static const barMargin:Number = 15;
		public static const yearBoxThickness:Number = 2;
		public static const yearBoxSize:Point = new Point(77 - barThickness, 21 - barThickness);
		public static function get yearTextFormat():TextFormat {
			var format:TextFormat = new TextFormat();
			format.font = "Verdana";
			format.size = 12;
			format.align = TextFormatAlign.CENTER;
			
			return format;
		}
		
		public static const mediaBoxColor:uint = 0xE0E0E0;
		public static const mediaBoxCornerSize:int = 6;
		public static const mediaBoxLineThickness:Number = 3;
		public static const mediaPreviewSize:Point = new Point(77, 55);
		public static const mediaPreviewOverRectColor:uint = 0xE67F23;
		public static const mediaPreviewOverThickness:Number = 2;
		public static const mediaBoxPointerSize:Point = new Point(10, 10);

	}
}
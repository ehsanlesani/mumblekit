package mumble.timerou.timebar.display
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	
	import mumble.timerou.timebar.data.Styles;

	public class YearBox extends MovieClip
	{
		private var year:int = 2000;
		
		public function YearBox(year:int) {
			this.year = year;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			graphics.beginFill(0xFFFFFF);
			graphics.lineStyle(Styles.yearBoxThickness, Styles.barColor);
			graphics.drawRoundRect(0, 0, Styles.yearBoxSize.x, Styles.yearBoxSize.y, Styles.cornerSize, Styles.cornerSize);
			graphics.endFill();
			var txt:TextField = new TextField();
			txt.defaultTextFormat = Styles.yearTextFormat;
			txt.text = year.toString();
			txt.width = Styles.yearBoxSize.x;
			txt.height = Styles.yearBoxSize.y;
			addChild(txt);
		}
	}
}
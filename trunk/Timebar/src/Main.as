package {
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import mumble.timerou.timebar.display.Timebar;

	[SWF(height = 600, width = 800, backgroundColor = 0xFFFFFF)]
	public class Main extends MovieClip
	{
		public static var BASEURL:String = "/";
		public static var BASEPICTURESURL:String = BASEURL + "Pictures/";
		public static var LOAD_SERVICE_URL:String = BASEURL + "MediaLoader.aspx/LoadMedias";
		public static var LOAD_PERYEAR_SERVICE_URL:String = BASEURL + "MediaLoader.aspx/LoadOneMediaPerYear/";
		
		private var leftArrow:LeftArrow = new LeftArrow();
		private var rightArrow:RightArrow = new RightArrow();
		
		public function Main() {			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var timebar:Timebar = new Timebar();
			addChild(timebar);

		}
	}
}

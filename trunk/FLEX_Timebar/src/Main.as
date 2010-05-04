package {
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.text.TextField;
	
	import mumble.timerou.timebar.display.Timebar;
	import mumble.timerou.timebar.events.MediaEvent;

	[SWF(height = 200, width = 800, backgroundColor = 0xFFFFFF)]
	public class Main extends MovieClip
	{
		public static var BASEURL:String = "http://localhost:1095/";
		public static var BASEPICTURESURL:String = BASEURL + "Pictures/";
		public static var LOAD_SERVICE_URL:String = BASEURL + "MediaLoader.aspx/LoadMedias";
		public static var LOAD_PERYEAR_SERVICE_URL:String = BASEURL + "MediaLoader.aspx/LoadOneMediaPerYear/";
		
		//private var debug:TextField = new TextField();
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
			
			timebar.addEventListener(MediaEvent.CLICK, onMediaClick);
			
			//debug.text = "Ciao";
			//addChild(debug);
		}
		
		private function onMediaClick(e:MediaEvent):void {
			//debug.text = e.mediaData.id + " " + ExternalInterface.available.toString();
			if(ExternalInterface.available) {				
				ExternalInterface.call("TimebarCom.onMediaClick", e.mediaData.id);
			}
		}
	}
}

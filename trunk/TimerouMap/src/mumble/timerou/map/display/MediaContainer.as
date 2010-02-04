package mumble.timerou.map.display
{
	import fl.controls.TextInput;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class MediaContainer extends MovieClip 
	{
		public var pictures:Array = new Array();
		
		private var page:int = 1;

		
		public function MediaContainer() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void {
			var txt:TextInput = new TextInput();
			txt.width = 250;
			txt.x = 10;
			txt.y = 10;
			
			var ret:Rettangolo = new Rettangolo();
			ret.x = 20;
			ret.y = 40;
			ret.width = 700;
			ret.height = 500;
			
			addChild(txt);
			addChild(ret);
		}
		
		public function load(pictures:Array):void {
			this.pictures = pictures;
		}
	}
}
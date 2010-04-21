package mumble.timerou.map.controls
{
	import fl.transitions.Tween;
	import fl.transitions.easing.Strong;
	
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextFormat;
	
	import mumble.timerou.map.display.Letter;
	import mumble.timerou.map.display.RoundContainer;
	import mumble.timerou.map.visualSpace.Margin;

	public class YearControl extends MovieClip
	{
		private var _width:int = 152;
		private var _height:int = 30;
		private var _radius:int = 8;
		private var _alpha:Number = 0.9;
		private var _margin:Margin = new Margin(5, 6);
		private var _tween:Tween = null;
		
		public function YearControl()		
		{			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{	
			drawControl(e);
			drawYear();
			
			stage.addEventListener(Event.RESIZE, drawControl);			
		}
		
		private function drawControl(e:Event):void 
		{
			this.x = stage.width - _width - _margin.right;
			this.y = _margin.top;
			
			addChild(new RoundContainer(_width, _height, _radius, _alpha));
		}
		
		private function drawYear():void 
		{
			var letter:Letter = new Letter("2");
			letter.y = -5;
			addChild(letter);
			_tween = new Tween(letter, "y", Strong.easeOut, 0, 22, 0.9,true);	
			_tween = new Tween(letter, "y", Strong.easeOut, 22, 0, 0.9,true);
		}
	}
}
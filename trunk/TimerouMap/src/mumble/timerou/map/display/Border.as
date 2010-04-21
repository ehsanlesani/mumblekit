package mumble.timerou.map.display
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Border extends Sprite {
		
		private var _radius:int = 0;		
		private var _myWidth:Number = 0;		
		private var _myHeight:Number = 0;
		private var _color:uint = 0xE1E1E1;
		
		public function Border(width:Number = 1, height:Number = 1, radius:int = 1) 
		{
			this._myWidth = width;
			this._myHeight = height;
			this._radius = radius;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function set Color(color:uint):void 
		{
			_color = color;
		}
				
		public function set Radius(radius:int):void 
		{
			_radius = radius;
		}
		
		public function get Radius():int 
		{
			return _radius;
		}
		
		private function init(e:Event):void 
		{
			drawBorder();
			
			stage.addEventListener(Event.RESIZE, drawBorder);	
		}
		
		private function drawBorder(e:Event = null):void 
		{
			graphics.clear();
			graphics.lineStyle(2, _color);
			graphics.drawRoundRect(0, 0, _myWidth, _myHeight, _radius, _radius);
		}
	}
}
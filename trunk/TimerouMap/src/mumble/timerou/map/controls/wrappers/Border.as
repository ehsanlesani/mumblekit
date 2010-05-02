package mumble.timerou.map.controls.wrappers
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Border extends Sprite {
		
		private var _radius:int = 0;		
		private var _width:Number = 0;		
		private var _height:Number = 0;
		private var _color:uint = 0xE1E1E1;
		
		public function Border(width:Number = 1, height:Number = 1, radius:int = 1) 
		{
			this._width = width;
			this._height = height;
			this._radius = radius;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function set Width(width:Number):void 
		{
			_width = width;
		}
		
		public function set Height(height:Number):void 
		{
			_height = height;
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
			graphics.drawRoundRect(0, 0, _width, _height, _radius, _radius);
		}
	}
}
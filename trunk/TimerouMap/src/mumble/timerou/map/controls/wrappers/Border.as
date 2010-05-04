package mumble.timerou.map.controls.wrappers
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import mumble.timerou.map.visualSpace.Dimension;
	
	public class Border extends Sprite {
				
		private var _dim:Dimension = new Dimension();
		private var _radius:int = 0;
		private var _color:uint = 0xE1E1E1;
		
		public function Border(width:Number = 1, height:Number = 1, radius:int = 1) 
		{			
			_dim.width = width;
			_dim.height = height;
			_radius = radius;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
				
		public function set dimension(dim:Dimension):void 
		{
			_dim = dim;
			drawBorder();
		}
		
		public function set color(color:uint):void 
		{
			_color = color;
		}
				
		public function set radius(radius:int):void 
		{
			_radius = radius;
		}
		
		public function get radius():int 
		{
			return _radius;
		}
		
		private function init(e:Event):void 
		{
			drawBorder();
			
			removeEventListener(Event.ADDED, init);
		}
		
		private function drawBorder(e:Event = null):void 
		{
			graphics.clear();
			graphics.lineStyle(2, _color);
			graphics.drawRoundRect(0, 0, _dim.width, _dim.height, _radius, _radius);
		}
	}
}
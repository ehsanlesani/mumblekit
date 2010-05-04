package mumble.timerou.map.visualSpace
{
	public class Bounds
	{
		private var _left:Number = 0;
		private var _right:Number = 0;
		private var _top:Number = 0;
		private var _bottom:Number = 0;
		
		public function Bounds()
		{
		}
		
		public function set left(value:Number):void 
		{
			_left = value;
		}
		
		public function get left():Number 
		{
			return _left;
		}
		
		public function set right(value:Number):void 
		{
			_right = value;
		}
		
		public function get right():Number 
		{
			return _right;
		}
		
		public function set top(value:Number):void 
		{
			_top = value;
		}
		
		public function get top():Number 
		{
			return _top;
		}
		
		public function set bottom(value:Number):void 
		{
			_bottom = value;
		}
		
		public function get bottom():Number 
		{
			return _bottom;
		}
	}
}
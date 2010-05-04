package mumble.timerou.map.visualSpace
{
	public class Dimension
	{
		private var _width:Number = 0;		
		private var _height:Number = 0;	
				
		public function Dimension(width:Number = 0, height:Number = 0)
		{
			_width = width;
			_height = height;
		}
		
		public function set width(value:Number):void 
		{
			_width = value;
		}
		
		public function set height(value:Number):void 
		{
			_height = value;
		}
		
		public function get width():Number 
		{
			return _width;
		}
		
		public function get height():Number
		{
			return _height;
		}
	}
}
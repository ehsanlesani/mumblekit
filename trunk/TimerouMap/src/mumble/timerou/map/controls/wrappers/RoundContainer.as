package mumble.timerou.map.controls.wrappers
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;

	public class RoundContainer extends Sprite
	{
		private var _drawBorder:Boolean = true;
		private var _border:Border = null;
		private var _roundRect:Shape = new Shape();
		private var _myWidth:Number = 0;
		private var _myHeight:Number = 0;
		private var _radius:int = 15;
		private var _myAlpha:Number = 1;
				
		public function RoundContainer(width:Number = 1, height:Number = 1, radius:int = 1, alpha:Number = 1)
		{	
			this._myWidth = width;
			this._myHeight = height;
			this._radius = radius;
			this._myAlpha = alpha;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
				
		public function set drawContainerBorder(value:Boolean):void 
		{
			_drawBorder = value;
		}
		
		private function init(e:Event):void 
		{
			if(_drawBorder) 
			{
				_border = new Border(_myWidth, _myHeight, _radius);
				addChild(_border);
			}
			
			drawRoundRectangle();
			addChild(_roundRect);
		}
		
		private function drawRoundRectangle():void 
		{
			var g:Graphics = _roundRect.graphics;
			g.clear();
			g.beginFill(0xFFFFFF);
			g.drawRoundRect(0, 0, _myWidth, _myHeight, _radius, _radius);
			g.endFill();
			
			_roundRect.alpha = _myAlpha;
		}
	}
}
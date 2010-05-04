package mumble.timerou.map.display
{
	import fl.transitions.Tween;
	import fl.transitions.easing.Regular;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author bruno
	 */
	public class MediaIcon extends Sprite
	{
		private var tween:Tween = null;
		
		public function MediaIcon() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			alpha = 0;
			var size:int = 7;
				
		    var matrix:Matrix = new Matrix();
			matrix.createGradientBox(
				size, 
				size,
				(Math.PI / 2) * 3);
			graphics.beginGradientFill(
				"linear", 
				[0xDD0000, 0xCC0000],
				[1, 1],
				[0, 255],
				matrix
				);
			graphics.lineStyle(2, 0xFFFFFF);
			graphics.drawCircle(0, 0, size);
			
			filters = [ new GlowFilter(0x000000, 0.5) ];
			
			tween = new Tween(this, "alpha", Regular.easeIn, 0, 1, 0.2, true);
		}

	}

}
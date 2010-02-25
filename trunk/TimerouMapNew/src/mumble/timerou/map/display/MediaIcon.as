package mumble.timerou.map.display
{
	import fl.transitions.easing.Regular;
	import fl.transitions.Tween;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
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
			var size:int = 6;
			graphics.beginFill(0xFC9803, 1);
			graphics.lineStyle(2, 0x000000);
			graphics.drawCircle(0, 0, size);
			
			//filters = [ new DropShadowFilter(2, 45, 0, 1, 2, 2) ];
			
			tween = new Tween(this, "alpha", Regular.easeIn, 0, 1, 0.2, true);
		}

	}

}
package  
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
	public class PictureIcon extends Sprite
	{
		public var picturePath:String = null;
		private var tween:Tween = null;
		
		public function PictureIcon(immediatePicturePath:String = null) 
		{
			picturePath = immediatePicturePath;
			if (picturePath != null) { init(); }
			else { addEventListener(Event.ADDED_TO_STAGE, init); }
		}
		
		private function init(e:Event = null):void {
			if (picturePath != null) {
				var request:URLRequest = new URLRequest(picturePath);				
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void { 
					drawPicture(loader.content as Bitmap);
				});
				loader.load(request);
			}
		}
		
		private function drawPicture(picture:Bitmap):void {
			alpha = 0;
			var size:int = 10;
			var scale:Number = size * 2 / picture.width;
			var matrix:Matrix = new Matrix();
			matrix.scale(scale, scale);			
			matrix.translate( size * -1, size * -1);
			graphics.beginFill(0xFFFFFF, 1);
			graphics.drawCircle(0, 0, size + 3);
			graphics.beginBitmapFill(picture.bitmapData, matrix, false);
			graphics.drawCircle(0, 0, size);
			
			filters = [ new DropShadowFilter(2, 45, 0, 1, 2, 2) ];
			
			tween = new Tween(this, "alpha", Regular.easeIn, 0, 1, 0.2, true);
		}
	}

}
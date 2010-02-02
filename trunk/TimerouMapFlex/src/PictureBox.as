package
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	public class PictureBox extends Sprite
	{
		public const BACKGROUND_COLOR:uint = 0x2F2F2F;
		public const BORDER_COLOR:uint = 0x3A3A3A;
		
		private var bitmap:Bitmap = null;
		
		public var url:String = null;
		public var pictureHeight:int = 50;
		public var pictureWidth:int = 100;
		public var padding:int = 3;
		
		public function PictureBox()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			var request:URLRequest = new URLRequest(this.url);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void {
				this.bitmap = loader.content as Bitmap;
				if(this.bitmap != null) {
					drawBox();
					drawPicture();
				}
			});
			loader.load(request);
		}
		
		private function drawBox():void {
			graphics.beginFill(BACKGROUND_COLOR, 1);
			graphics.lineStyle(1, BORDER_COLOR);
			graphics.drawRect(0, 0, width + padding * 2, height + padding * 2);
			graphics.endFill();
		}
		
		private function drawPicture:void {
			//calculate tranformation matrix
			var dx:int = (this.bitmap.width - pictureWidth) / 2;
			var dy:int = (this.bitmap.height - pictureHeight) / 2;			
			matrix.translate(dx, dy);			
			graphics.beginBitmapFill(bitmap.bitmapData, matrix, true, true);
			graphics.lineStyle(1, 0xFFFFFF);
			graphics.drawRect(PADDING, PADDING, pictureWidth, pictureHeight);
			graphics.endFill();
		}

	}
}
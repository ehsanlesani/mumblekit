package mumble.timerou.map.display
{
	import fl.transitions.Tween;
	import fl.transitions.easing.Regular;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import mumble.timerou.map.data.PictureData;
	
	public class PictureBox extends MovieClip
	{
		public const BACKGROUND_COLOR:uint = 0x515151;
		public const BORDER_COLOR:uint = 0x7C7C7C;
		public const TEXT_HEIGHT:int = 14;
		
		private var bitmap:Bitmap = null;
		private var tween:Tween = null;
		
		public var pictureData:PictureData = null;
		public var pictureHeight:int = 50;
		public var pictureWidth:int = 100;
		public var padding:int = 5;
		
		public function PictureBox()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			try {
				var request:URLRequest = new URLRequest(Main.BASEURL + pictureData.avatarPath);
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void {
					bitmap = loader.content as Bitmap;
					if(bitmap != null) {
						drawBox();
						drawPicture();
						drawTitle();
						animate();
					}
				});
				loader.load(request);
			}
			catch (err:Error)
			{
				trace(err);
			}
		}
		
		private function drawBox():void {
			graphics.beginFill(BACKGROUND_COLOR, 1);
			graphics.lineStyle(1, BORDER_COLOR);
			graphics.drawRect(0, 0, pictureWidth + padding * 2, pictureHeight + padding * 2 + TEXT_HEIGHT);
			graphics.endFill();
		}
		
		private function drawPicture():void {
			//calculate tranformation matrix
			var matrix:Matrix = new Matrix();
			var dx:int = (this.bitmap.width - pictureWidth) / 2;
			var dy:int = (this.bitmap.height - pictureHeight) / 2;			
			//matrix.translate(dx, dy);			
			graphics.beginBitmapFill(bitmap.bitmapData, matrix, true, true);
			graphics.lineStyle(1, 0xEEEEEE);
			graphics.drawRect(padding, padding, pictureWidth, pictureHeight);
			graphics.endFill();
		}
		
		private function drawTitle():void {
			var txt:TextField =new TextField();
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.LEFT;
			format.font = "verdana";
			format.size = 10;
			format.color = 0xDDDDDD;
			format.bold = true;
			txt.defaultTextFormat = format;
			txt.width = pictureWidth;
			txt.height = TEXT_HEIGHT;
			txt.x = this.padding;
			txt.y = this.padding + this.pictureHeight;
			txt.text = pictureData.title;
			
			addChild(txt);
		}
		
		private function animate():void {
			tween = new Tween(this, "alpha", Regular.easeIn, 0, 1, 0.25, true);
		}

	}
}
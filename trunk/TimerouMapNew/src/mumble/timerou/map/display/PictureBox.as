package mumble.timerou.map.display
{
	import fl.transitions.Tween;
	import fl.transitions.easing.Regular;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.setTimeout;
	
	import mumble.timerou.map.data.PictureData;
	
	public class PictureBox extends MovieClip
	{
		public const BACKGROUND_COLOR:uint = 0xFFFFFF;
		public const OVER_BACKGROUND_COLOR:uint = 0xEEEEEE;
		public const BORDER_COLOR:uint = 0xEEEEEE;
		public const OVER_BORDER_COLOR:uint = 0x7C7C7C;
		public const TEXT_COLOR:uint = 0x333333;
		
		private var bitmap:Bitmap = null;
		private var tween:Tween = null;
		private var loading:Loading = null;
		private var pictureSprite:Sprite = new Sprite();
		
		public var pictureData:PictureData = null;
		public var pictureHeight:int = 100;
		public var pictureWidth:int = 100;
		public var textHeight:int = 16;
		public var padding:int = 5;
		
		
		public function PictureBox(pictureData:PictureData)
		{
			this.pictureData = pictureData;
			
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {			
			addEventListener(MouseEvent.ROLL_OVER, function(e:MouseEvent):void { drawBox(true); });
			addEventListener(MouseEvent.ROLL_OUT, function(e:MouseEvent):void { drawBox(false); });
			
			try {
				drawBox();
				drawLoading();
				drawTitle();
				animate();
				
				var request:URLRequest = new URLRequest(Main.BASEPICTURESURL + pictureData.avatarPath);
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void {
					bitmap = loader.content as Bitmap;
					if(bitmap != null) {
						drawPicture();
					}
				});
				setTimeout(function():void { loader.load(request); }, 3000);
			}
			catch (err:Error)
			{
				trace(err);
			}
		}
		
		private function drawBox(over:Boolean = false):void {
			if(over) { graphics.beginFill(OVER_BACKGROUND_COLOR, 1); }
			else { graphics.beginFill(BACKGROUND_COLOR, 1); }
			if(over) { graphics.lineStyle(1, OVER_BORDER_COLOR); }
			else { graphics.lineStyle(1, BORDER_COLOR); }
			
			graphics.drawRect(0, 0, pictureWidth + padding * 2, pictureHeight + padding * 2);
			graphics.endFill();
		}
		
		private function drawPicture():void {
			//remove loading if there is
			if(this.loading != null) {
				removeChild(this.loading);
			}
			
			//calculate tranformation matrix
			var matrix:Matrix = new Matrix();
			matrix.translate(padding, padding);
			var dx:int = (this.bitmap.width - pictureWidth) / 2;
			var dy:int = (this.bitmap.height - pictureHeight) / 2;			
			pictureSprite.graphics.beginBitmapFill(bitmap.bitmapData, matrix, true, true);
			pictureSprite.graphics.drawRect(padding, padding, pictureWidth, pictureHeight);
			pictureSprite.graphics.endFill();
			pictureSprite.buttonMode = true;
			addChild(pictureSprite);
		}
		
		private function drawLoading():void {
			this.loading = new Loading();
			addChild(loading);
			loading.x = this.width / 2;
			loading.y = this.height / 2;
		}
		
		private function drawTitle():void {
			var txt:TextField =new TextField();
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			format.font = "verdana";
			format.size = 10;
			format.color = TEXT_COLOR;
			txt.defaultTextFormat = format;
			txt.width = pictureWidth;
			txt.height = textHeight;
			txt.x = this.padding;
			txt.y = this.padding * 2 + this.pictureHeight;
			txt.text = pictureData.title;
			
			addChild(txt);
		}
		
		private function animate():void {
			tween = new Tween(this, "alpha", Regular.easeIn, 0, 1, 0.25, true);
		}

	}
}
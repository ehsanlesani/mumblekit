package mumble.timerou.map.display
{
	import fl.transitions.Tween;
	import fl.transitions.easing.Strong;
	
	import flash.display.Bitmap;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import mumble.timerou.map.data.PictureData;
	
	public class MiniSlideshow extends MovieClip
	{
		private const WIDTH:int = 105;
		private const HEIGHT:int = 105;
		private const PICTURE_WIDTH:int = 100; 
		private const PICTURE_HEIGHT:int = 100;
		private const BACKGROUND_COLOR:uint = 0x333333;
		private const BACKGROUND_ALPHA:Number = 1;
		private const BORDER_COLOR:uint = 0x999999;
		private const ROUND_SIZE:int = 0;
		private const SLIDESHOW_DELAY:int = 3000; //milliseconds
		
		private var contentRectangle:Shape = null;
		private var pictures:Array = null;
		private var slideshowTimer:Timer = null;
		private var currentPictureIndex:int = 0;
		private var currentPictureSprite:Sprite = null;
		private var tween:Tween = null;
	
		public function MiniSlideshow() {
			this.contentRectangle = new Shape();
			this.slideshowTimer = new Timer(SLIDESHOW_DELAY, 0);
			this.slideshowTimer.addEventListener(TimerEvent.TIMER, nextSlideshowImage);			
			this.visible = false; //start as invisible!
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			stage.addEventListener(Event.RESIZE, onStageResize);	
					
			this.contentRectangle = new Shape();	
			addChild(this.contentRectangle);		
			drawContentRectangle();				
		}
		
		private function onStageResize(e:Event):void {
			drawContentRectangle();	
		}
		
		private function removeAllPictures():void {
			var childs:Array = new Array();
			for (var i:int = 0; i<this.numChildren; i++) {
				var picture:PictureBox = this.getChildAt(i) as PictureBox;
			    if(picture != null) {
			    	childs.push(i);			    	
			    }
			}
			for (i = 0; i < childs.length; i++){
			    this.removeChild(this.getChildAt(childs[i]));
			}
		}
		
		private function drawContentRectangle():void {
			var g:Graphics = this.contentRectangle.graphics;
			g.clear();
			g.beginFill(BACKGROUND_COLOR, BACKGROUND_ALPHA);
			g.drawRect(0, 0, WIDTH, HEIGHT);
			g.endFill();
			g.lineStyle(1, BORDER_COLOR);
			g.moveTo(WIDTH, 0);
			g.lineTo(WIDTH, HEIGHT);
			g.lineTo(0, HEIGHT);
			g.endFill();
		}
		
		public function getCurrentSlideshowPicture():PictureData {
			if(this.pictures == null || this.pictures.length == 0) { return null; }
			return this.pictures[this.currentPictureIndex];	
		}
		
		public function startSlideshow():void {
			if(this.pictures == null || this.pictures.length == 0) { return; }	
			this.slideshowTimer.stop();	
			this.currentPictureIndex = -1;
			this.nextSlideshowImage();			
		}
		
		private function nextSlideshowImage(e:TimerEvent = null):void {
			if(this.pictures == null || this.pictures.length == 0) {
				this.slideshowTimer.stop();
				return;
			}
			this.currentPictureIndex++;
			if(this.currentPictureIndex >= this.pictures.length) {
				this.currentPictureIndex = 0;
			}
			
			var request:URLRequest = new URLRequest(Main.BASEURL + this.pictures[this.currentPictureIndex].avatarPath);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void {				
				//dispatch event to show picture on the map
				dispatchEvent(new Event("slideshowChanged"));				
				drawSlideshowPicture(loader.content as Bitmap);				
				//if there is just 1 picture, no slideshow is needed!
				if(pictures.length > 1 ) { slideshowTimer.start(); }
			});
			loader.load(request);
			this.slideshowTimer.stop();
		}
		
		private function drawSlideshowPicture(bitmap:Bitmap):void {
			if(bitmap == null) {
				trace("bitmap is null");
			} else {
				var sprite:Sprite = new Sprite();
				var g:Graphics = sprite.graphics;
				g.beginBitmapFill(bitmap.bitmapData);
				g.lineStyle(1, 0xDDDDDD);				
				g.drawRect(0, 0, PICTURE_WIDTH, PICTURE_HEIGHT);
				g.endFill();
				g.lineStyle(1, BORDER_COLOR);
				g.moveTo(PICTURE_WIDTH, 0);
				g.lineTo(PICTURE_WIDTH, PICTURE_HEIGHT);
				g.lineTo(0, PICTURE_HEIGHT);
				
				this.addChild(sprite);
				//animate new picture
				this.tween = new Tween(sprite, "alpha", Strong.easeOut, 0, 1, 0.5, true);
				//remove last picture from stage
				setTimeout(function():void {
					if(currentPictureSprite != null) {
						removeChild(currentPictureSprite);
					}
					currentPictureSprite = sprite;
				}, 250);
			}

		}

		public function load(pictures:Array):void {
			if(currentPictureSprite != null) {
				removeChild(currentPictureSprite);
				currentPictureSprite = null;
			}
			
			this.pictures = pictures;
			trace(this.pictures.length);			
			this.slideshowTimer.stop();
			if(this.pictures.length > 0) {
				this.show();
				this.startSlideshow();
			} else {
				this.hide();
			}
		}
		
		public function hide():void {
			if(this.tween != null && this.tween.isPlaying) {
				this.tween.stop();
			}
			this.slideshowTimer.stop();
			this.tween = new Tween(this, "alpha", Strong.easeOut, 1, 0, 0.5, true);
			setTimeout(function():void { visible = false; }, 500);
		}		
		
		public function show():void {
			if(this.tween != null && this.tween.isPlaying) {
				this.tween.stop();
			}
			this.visible = true;
			this.tween = new Tween(this, "alpha", Strong.easeOut, 0, 1, 0.5, true);
		}	
		
	}
}

	
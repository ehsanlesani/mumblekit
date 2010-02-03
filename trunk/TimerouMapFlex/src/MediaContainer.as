package
{
	import fl.transitions.TransitionManager;
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
	import flash.filters.DropShadowFilter;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	public class MediaContainer extends MovieClip
	{
		public const DISPLAY_MAXIMIZED:int = 0;
		public const DISPLAY_MINIMIZED:int = 1;
		
		private const MINIMIZED_WIDTH:int = 105;
		private const MINIMIZED_HEIGHT:int = 105;
		private const MINIMIZED_PICTURE_WIDTH:int = 100; 
		private const MINIMIZED_PICTURE_HEIGHT:int = 100;
		private const BACKGROUND_COLOR:uint = 0xFFFFFF;
		private const BACKGROUND_ALPHA:Number = 1;
		private const BORDER_COLOR:uint = 0x999999;
		private const ROUND_SIZE:int = 0;
		private const SLIDESHOW_DELAY:int = 3000; //milliseconds
		
		private var displayMode:int = DISPLAY_MINIMIZED;
		private var contentRectangle:Shape = null;
		private var enterTransition:TransitionManager = null;
		private var pictures:Array = null;
		private var slideshowTimer:Timer = null;
		private var currentPictureIndex:int = 0;
		private var currentPicture:Sprite = null;
		private var tween:Tween = null;
	
		public function MediaContainer() {
			this.contentRectangle = new Shape();
			this.enterTransition = new TransitionManager(this);
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
			
			if(this.displayMode == DISPLAY_MINIMIZED) {
				g.drawRect(0, 0, MINIMIZED_WIDTH, MINIMIZED_HEIGHT);
				g.endFill();
				g.lineStyle(1, BORDER_COLOR);
				g.moveTo(MINIMIZED_WIDTH, 0);
				g.lineTo(MINIMIZED_WIDTH, MINIMIZED_HEIGHT);
				g.lineTo(0, MINIMIZED_HEIGHT);
				/*g.moveTo(0, 0),
				g.lineTo(MINIMIZED_WIDTH, 0);
				g.lineTo(MINIMIZED_WIDTH, MINIMIZED_HEIGHT - ROUND_SIZE);
				g.curveTo(MINIMIZED_WIDTH, MINIMIZED_HEIGHT, MINIMIZED_WIDTH - ROUND_SIZE, MINIMIZED_HEIGHT);
				g.lineTo(0, MINIMIZED_HEIGHT);
				*/
				this.contentRectangle.filters = [ new DropShadowFilter() ];
			}
			
			g.endFill();
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
				drawSlideshowPicture(loader.content as Bitmap);
				slideshowTimer.start();
			});
			loader.load(request);
			this.slideshowTimer.stop();
		}
		
		private function drawSlideshowPicture(bitmap:Bitmap):void {
			trace("drawing picture ", this.currentPictureIndex); 
			
			if(bitmap == null) {
				trace("bitmap is null");
			} else {
				var sprite:Sprite = new Sprite();
				var g:Graphics = sprite.graphics;
				g.beginBitmapFill(bitmap.bitmapData);
				g.lineStyle(1, 0xDDDDDD);				
				g.drawRect(0, 0, MINIMIZED_PICTURE_WIDTH, MINIMIZED_PICTURE_HEIGHT);
				g.endFill();
				g.lineStyle(1, BORDER_COLOR);
				g.moveTo(MINIMIZED_PICTURE_WIDTH, 0);
				g.lineTo(MINIMIZED_PICTURE_WIDTH, MINIMIZED_PICTURE_HEIGHT);
				g.lineTo(0, MINIMIZED_PICTURE_HEIGHT);
				
				this.addChild(sprite);
				//animate new picture
				this.tween = new Tween(sprite, "alpha", Strong.easeOut, 0, 1, 0.5, true);
				//remove last picture from stage
				setTimeout(function():void {
					trace("removing last picture..."); 
					if(currentPicture != null) {
						removeChild(currentPicture);
					}
					currentPicture = sprite;
				}, 250);
			}

		}

		public function load(pictures:Array):void {
			this.pictures = pictures;
			trace(this.pictures.length);			
			if(this.displayMode == DISPLAY_MINIMIZED) {
				this.slideshowTimer.stop();
				if(this.pictures.length > 0) {
					this.visible = true;
					this.startSlideshow();
				} else {
					this.visible = false;
				}
			}
		}
		
		public function changeDisplayMode(displayMode:int):void {
			this.displayMode = displayMode;
		}
		
	}
}

	
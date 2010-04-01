package mumble.timerou.map.display
{
	import fl.transitions.Tween;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import mumble.timerou.map.data.MediaData;
	import mumble.timerou.map.data.MediaDataLoader;
	import mumble.timerou.map.data.PictureEvent;
	import mumble.timerou.map.data.RemotePicture;
	
	public class MediaBar extends MovieClip
	{
		public static const LOADING_PICTURES:String = "loadingPictures";
		public static const PICTURE_CLICK:String = "pictureClick";
		
		private const WIDTH:Number = 0.35;
		private const MARGIN:int = 5;
		private const PICTURE_WIDTH:int = 50; 
		private const PICTURE_HEIGHT:int = 50;
		private const BACKGROUND_COLOR:uint = 0xFFFFFF;
		private const BORDER_COLOR:uint = 0xFFFFFF;
		private const PICTURE_BORDER_COLOR:uint = 0x333333;
		private const PICTURE_BORDER_OVER_COLOR:uint = 0xFC9803;
		private const BACKGROUND_ALPHA:Number = 1;
		private const ROUND_SIZE:int = 0;
		private const TEXT_COLOR:uint = 0xEEEEEE;
		
		private var displayNumber:int = 0;
		private var yDistance:int = 0;
		private var background:Sprite = null;
		private var loadedMediaSprites:Array = null;
		private var tween:Tween = null;
		private var boundsTween:Tween = null;
		private var preview:Preview = null;
		private var correctMargin:Number = 0;				
		private var mapMoveTimer:Timer = null;
		private var mediaDataLoader:MediaDataLoader = null;
		private var year:int = 0;
		private var computedWidth:Number = 100;
		private var rows:int = 10;
		private var cols:int = 10;

		public var map:TimerouMap = null;
		
		public function MediaBar() {
			mapMoveTimer = new Timer(1000, 1);
			mapMoveTimer.addEventListener(TimerEvent.TIMER_COMPLETE, mapMoveTimerComplete);
			mediaDataLoader = new MediaDataLoader();
			mediaDataLoader.addEventListener(Event.COMPLETE, load);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			preview = new Preview();
			addChild(preview);
			
			drawBackground();
			setupInterface();
			drawMoveButtons();
			/*addEventListener(MouseEvent.ROLL_OUT, function(e:MouseEvent):void { restoreBackgroundAlpha();; preview.hide(); });*/
			
			stage.addEventListener(Event.RESIZE, function(e:Event):void { 
				clearPictures();
				clearLocations();
				
				drawBackground();
				setupInterface();
				drawMoveButtons();
				
				mapMoveEnd();
			});
			
			map.addEventListener("timerouMapMoveStart", mapMoveStart);
			map.addEventListener("timerouMapMoveEnd", mapMoveEnd);
		}
		
		private function drawBackground():void {
			if(background == null) {
				background = new Sprite();
				addChild(background);
			}
			
			background.graphics.clear();
			background.graphics.beginFill(BACKGROUND_COLOR, BACKGROUND_ALPHA),
			background.graphics.drawRect(stage.stageWidth - this.computedWidth, 0, this.computedWidth, stage.stageHeight);
			background.graphics.lineStyle(1, BORDER_COLOR);
		}
		
		private function setupInterface():void {
			correctMargin = MARGIN;			
			this.computedWidth = stage.stageWidth * WIDTH;
		}

		private function drawMoveButtons():void {
			/*if(nextButton == null) {
								
				nextButton.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
					if(pictureDataLoader != null) {
						pictureDataLoader.loadNext();
					}
				});
				
				previousButton.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
					if(pictureDataLoader != null) {
						pictureDataLoader.loadPrevious();
					}
				});
			}		*/		

		}
		

		private function clearPictures():void {
			if(loadedMediaSprites != null) {
				for each(var obj:DisplayObject in loadedMediaSprites) {
					background.removeChild(obj);	
				}
			}
			
			loadedMediaSprites = null;
		}
		
		private function createPictureSprite(mediaData:MediaData):Sprite {
			var self:MovieClip = this;
			
			var remotePicture:RemotePicture = new RemotePicture(Main.BASEPICTURESURL + mediaData.pictureData.avatarPath, PICTURE_WIDTH, PICTURE_HEIGHT, false);
			remotePicture.borderColor = PICTURE_BORDER_COLOR;
			remotePicture.borderOverColor = PICTURE_BORDER_OVER_COLOR;
			remotePicture.roundCornerSize = ROUND_SIZE;
			remotePicture.buttonMode = true;
			remotePicture.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
				dispatchEvent(new PictureEvent(PICTURE_CLICK, mediaData));
			});
			
			remotePicture.addEventListener(MouseEvent.ROLL_OVER, function(e:MouseEvent):void {
				movePreview(mediaData);
			});
			
			/*remotePicture.addEventListener(MouseEvent.ROLL_OUT, function(e:MouseEvent):void {
				if(map != null) { map.clearPictureLocation(); }
			});*/
			return remotePicture;
		}
		
		private function movePreview(pictureData:MediaData):void {
			var point:Point = map.getPicturePoint(pictureData);

			if(!preview.visible) { 
				preview.show(point);
			} else { 
				preview.move(point);
			}
			preview.loadMedia(pictureData);
		}
		
		private function mapMoveTimerComplete(e:TimerEvent):void {
			this.loadPictures();
		}
		
		private function mapMoveStart(e:Event = null):void {
			if(preview != null && preview.visible) {
				preview.hide();
			}
			this.mapMoveTimer.stop();
		}
		
		private function mapMoveEnd(e:Event = null):void {
			this.mapMoveTimer.stop();
			this.mapMoveTimer.start();
		}
		
		private function loadPictures():void {
			if(year != 0) { 
				dispatchEvent(new Event(LOADING_PICTURES));
				
				mediaDataLoader.pageSize = displayNumber;
				mediaDataLoader.load(map.latLngBounds, year);
			}
		}
		
		private function load(e:Event):void {
			if(preview != null && preview.visible) {
				preview.hide();
			}
			
			//previousButton.enabled = mediaDataLoader.hasMorePagesBefore;
			//nextButton.enabled = mediaDataLoader.hasMorePagesAfter;
			var pictures:Array = mediaDataLoader.medias;
			
			//clear
			clearPictures();			
			clearLocations();
			
			loadedMediaSprites = new Array();
			var counter:int = 0;
			
			for each(var pictureData:MediaData in pictures) {
				var sprite:Sprite = createPictureSprite(pictureData);
				//sprite.x = MOVE_BUTTONS_WIDTH + MARGIN + MARGIN + (correctMargin * counter) + (counter * PICTURE_WIDTH);
				sprite.y = MARGIN;
				background.addChild(sprite);
				loadedMediaSprites.push(sprite);				
				counter++;
				createIcon(pictureData);
				if(counter == displayNumber) { break; }
			}
		}
		
		private function createIcon(pictureData:MediaData):void {
			var icon:MediaIcon = map.showMediaLocation(pictureData);
			icon.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
				movePreview(pictureData);
			});
		}
		
		/*private function restoreBackgroundAlpha():void {
			if(boundsTween != null && boundsTween.isPlaying) {
				boundsTween.stop();
			}
			
			background.alpha = 1;
		}*/
		
		/*public function show():void {
			if(visible) { return; }
			visible = true;
			tween = new Tween(this, "y", Strong.easeOut, HEIGHT * -1, 0, 0.25, true);
		}
		
		public function hide():void {
			if(!visible) { return; }
			tween = new Tween(this, "y", Strong.easeOut, this.y, HEIGHT * -1, 0.25, true);
			setTimeout(function():void { visible = false; }, 250);
		}*/
		
		public function clearLocations():void {
			if(map != null) {
				map.clearMediaLocations();
			}
		}
		
		public function changeYear(year:int):void {
			this.year = year;
			mapMoveEnd();
		}
	}
}
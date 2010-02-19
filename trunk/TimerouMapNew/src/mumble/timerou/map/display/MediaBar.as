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
	
	import mumble.timerou.map.data.PictureData;
	import mumble.timerou.map.data.PictureDataLoader;
	import mumble.timerou.map.data.RemotePicture;
	
	public class MediaBar extends MovieClip
	{
		public static const LOADING_PICTURES:String = "loadingPictures";
		
		private const HEIGHT:int = 60;
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
		private const MOVE_BUTTONS_WIDTH:int = 10;
		
		private const DOCK_PICTURE_SIZE:int = 50;
		private const DOCK_PADDING:int = 5;
		private const DOCK_CORNER:int = 3;
		
		private var displayNumber:int = 0;
		private var yDistance:int = 0;
		private var background:Sprite = null;
		private var loadedMediaSprites:Array = null;
		private var tween:Tween = null;
		private var boundsTween:Tween = null;
		private var preview:Preview = null;
		private var correctMargin:Number = 0;				
		private var nextButton:ForwardArrow = null;
		private var previousButton:BackwardArrow = null;
		private var mapMoveTimer:Timer = null;
		private var pictureDataLoader:PictureDataLoader = null;
		private var year:int = 0;

		public var map:TimerouMap = null;
		
		public function MediaBar() {
			mapMoveTimer = new Timer(1000, 1);
			mapMoveTimer.addEventListener(TimerEvent.TIMER_COMPLETE, mapMoveTimerComplete);
			pictureDataLoader = new PictureDataLoader();
			pictureDataLoader.addEventListener(Event.COMPLETE, load);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			//var self:MovieClip = this;
			preview = new Preview();
			/*preview.addEventListener(Preview.MOVE_COMPLETE, function(e:Event):void {
				var bounds:Rectangle = preview.getBounds(self);
				
				if(bounds.y <= HEIGHT) {
					boundsTween = new Tween(background, "alpha", Strong.easeOut, background.alpha, 0.3, 0.25, true);
				} else {
					restoreBackgroundAlpha();
				}
			}); */
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
			background.graphics.drawRect(0, 0, stage.stageWidth, HEIGHT);
			background.graphics.lineStyle(1, BORDER_COLOR);
			background.graphics.moveTo(0, HEIGHT);
			background.graphics.lineTo(stage.stageWidth, HEIGHT);
			background.y = stage.stageHeight - HEIGHT;
		}
		
		private function setupInterface():void {
			var workWidth:Number = stage.stageWidth - MOVE_BUTTONS_WIDTH * 2 - MARGIN * 2;			
			displayNumber = workWidth / (PICTURE_WIDTH + MARGIN);
			//calculate correct margin
			var size:int = PICTURE_WIDTH * displayNumber + MARGIN * 2;
			var delta:int = workWidth - size;
			correctMargin = delta / (displayNumber - 1); 
		}

		private function drawMoveButtons():void {
			if(nextButton == null) {
				nextButton = new ForwardArrow();
				nextButton.width = MOVE_BUTTONS_WIDTH;
				nextButton.height /= 2;
				previousButton = new BackwardArrow();
				previousButton.width = MOVE_BUTTONS_WIDTH;
				previousButton.height /= 2;
				background.addChild(previousButton);
				background.addChild(nextButton);
				
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
			}				
			
			nextButton.x = stage.stageWidth - nextButton.width - MARGIN;		
			previousButton.x = MARGIN;
			nextButton.y = HEIGHT / 3;
			previousButton.y = HEIGHT / 3;
		}
		
		/*private function createOldPictureSprite(pictureData:PictureData):Sprite {
			var sprite:Sprite = new Sprite();
			var remotePicture:RemotePicture = new RemotePicture(Main.BASEPICTURESURL + pictureData.avatarPath, DOCK_PICTURE_SIZE, DOCK_PICTURE_SIZE);
			remotePicture.borderColor = PICTURE_BORDER_COLOR;
			remotePicture.borderOverColor = PICTURE_BORDER_OVER_COLOR;
			remotePicture.x = DOCK_PADDING;
			remotePicture.y = DOCK_PADDING;
			sprite.addChild(remotePicture);
			var txt:TextField = new TextField();
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.LEFT;
			format.font = "verdana";
			format.size = 12;
			format.color = TEXT_COLOR;
			txt.defaultTextFormat = format;
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.text = pictureData.year.toString();
			txt.x = DOCK_PICTURE_SIZE + 5;
			sprite.addChild(txt);
			txt.y = DOCK_PICTURE_SIZE / 2 - txt.height / 2;
			
			//draw background under text
			sprite.graphics.beginFill(BACKGROUND_COLOR);
			sprite.graphics.lineStyle(1, BORDER_COLOR);
			sprite.graphics.drawRect(0, 0, DOCK_PICTURE_SIZE + txt.width + DOCK_PADDING * 2, DOCK_PICTURE_SIZE + DOCK_PADDING * 2);
			sprite.graphics.endFill();
			return sprite;
		}*/
		
		private function clearPictures():void {
			if(loadedMediaSprites != null) {
				for each(var obj:DisplayObject in loadedMediaSprites) {
					background.removeChild(obj);	
				}
			}
			
			loadedMediaSprites = null;
		}
		
		private function createPictureSprite(pictureData:PictureData):Sprite {
			var self:MovieClip = this;
			
			var remotePicture:RemotePicture = new RemotePicture(Main.BASEPICTURESURL + pictureData.avatarPath, PICTURE_WIDTH, PICTURE_HEIGHT, false);
			remotePicture.borderColor = PICTURE_BORDER_COLOR;
			remotePicture.borderOverColor = PICTURE_BORDER_OVER_COLOR;
			remotePicture.roundCornerSize = ROUND_SIZE;
			/*remotePicture.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
				if(preview.visible) { preview.hide(); }
				var sprite:Sprite = createOldPictureSprite(pictureData);
				sprite.x = 100;
				sprite.y = 100;
				addChild(sprite);
			});*/
			
			remotePicture.addEventListener(MouseEvent.ROLL_OVER, function(e:MouseEvent):void {
				movePreview(pictureData);
			});
			
			/*remotePicture.addEventListener(MouseEvent.ROLL_OUT, function(e:MouseEvent):void {
				if(map != null) { map.clearPictureLocation(); }
			});*/
			return remotePicture;
		}
		
		private function movePreview(pictureData:PictureData):void {
			var point:Point = map.getPicturePoint(pictureData);

			if(!preview.visible) { 
				preview.show(point);
			} else { 
				preview.move(point);
			}
			preview.loadPicture(pictureData);
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
				
				pictureDataLoader.pageSize = displayNumber;
				pictureDataLoader.load(map.latLngBounds, year);
			}
		}
		
		private function load(e:Event):void {
			if(preview != null && preview.visible) {
				preview.hide();
			}
			
			previousButton.enabled = pictureDataLoader.hasMorePagesBefore;
			nextButton.enabled = pictureDataLoader.hasMorePagesAfter;
			var pictures:Array = pictureDataLoader.pictures;
			
			//clear
			clearPictures();			
			clearLocations();
			
			loadedMediaSprites = new Array();
			var counter:int = 0;
			
			for each(var pictureData:PictureData in pictures) {
				var sprite:Sprite = createPictureSprite(pictureData);
				sprite.x = MOVE_BUTTONS_WIDTH + MARGIN + MARGIN + (correctMargin * counter) + (counter * PICTURE_WIDTH);
				sprite.y = MARGIN;
				background.addChild(sprite);
				loadedMediaSprites.push(sprite);				
				counter++;
				createIcon(pictureData);
				if(counter == displayNumber) { break; }
			}
		}
		
		private function createIcon(pictureData:PictureData):void {
			var icon:PictureIcon = map.showPictureLocation(pictureData);
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
				map.clearPictureLocations();
			}
		}
		
		public function changeYear(year:int):void {
			this.year = year;
			mapMoveEnd();
		}
	}
}
package mumble.timerou.map.display
{
	import fl.transitions.Tween;
	import fl.transitions.easing.Strong;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.setTimeout;
	
	import mumble.timerou.map.data.PictureData;
	import mumble.timerou.map.data.RemotePicture;
	
	public class MediaBar extends MovieClip
	{
		private const HEIGHT:int = 60;
		private const MARGIN:int = 5;
		private const PICTURE_WIDTH:int = 50; 
		private const PICTURE_HEIGHT:int = 50;
		private const BACKGROUND_COLOR:uint = 0x333333;
		private const BORDER_COLOR:uint = 0x555555;
		private const BORDER_OVER_COLOR:uint = 0xEEEEEE;
		private const BACKGROUND_ALPHA:Number = 1;
		private const ROUND_SIZE:int = 0;
		private const TEXT_COLOR:uint = 0xEEEEEE;
		
		private const DOCK_PICTURE_SIZE:int = 50;
		private const DOCK_PADDING:int = 5;
		private const DOCK_CORNER:int = 3;
		
		private var displayNumber:int = 0;
		private var yDistance:int = 0;
		private var loadedMediaSprites:Array = null;
		private var tween:Tween = null;
		private var preview:Preview = null;

		public var map:TimerouMap = null;
		
		public function MediaBar() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			
			preview = new Preview();
			addChild(preview);
			
			drawBackground();
			setupInterface();
			
			addEventListener(MouseEvent.ROLL_OUT, function(e:MouseEvent):void { preview.hide(); });
		}
		
		private function drawBackground():void {
			graphics.beginFill(BACKGROUND_COLOR, BACKGROUND_ALPHA),
			graphics.drawRect(0, 0, stage.stageWidth, HEIGHT);
			graphics.lineStyle(1, BORDER_COLOR);
			graphics.moveTo(0, HEIGHT);
			graphics.lineTo(stage.stageWidth, HEIGHT);
		}
		
		private function setupInterface():void {
			displayNumber = stage.stageWidth / (PICTURE_WIDTH + MARGIN);
		}
		
		private function createOldPictureSprite(pictureData:PictureData):Sprite {
			var sprite:Sprite = new Sprite();
			var remotePicture:RemotePicture = new RemotePicture(Main.BASEPICTURESURL + pictureData.avatarPath, DOCK_PICTURE_SIZE, DOCK_PICTURE_SIZE);
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
		}
		
		public function load(pictures:Array):void {
			//clear
			if(loadedMediaSprites != null) {
				for each(var obj:DisplayObject in loadedMediaSprites) {
					removeChild(obj);	
				}
			}
			
			loadedMediaSprites = new Array();
			var counter:int = 0;
			
			//calculate correct margin
			var size:int = PICTURE_WIDTH * displayNumber + MARGIN;
			var delta:int = stage.stageWidth - size;
			var correctMargin:Number = delta / displayNumber; 
			
			for each(var pictureData:PictureData in pictures) {
				var sprite:Sprite = createPictureSprite(pictureData);
				sprite.x = correctMargin + (correctMargin * counter) + (counter * PICTURE_WIDTH);
				sprite.y = MARGIN;
				addChild(sprite),
				loadedMediaSprites.push(sprite);				
				counter++;
				if(counter == displayNumber) { break; }
			}
		}
		
		public function createPictureSprite(pictureData:PictureData):Sprite {
			var remotePicture:Sprite = new RemotePicture(Main.BASEPICTURESURL + pictureData.avatarPath, PICTURE_WIDTH, PICTURE_HEIGHT, false);
			remotePicture.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
				if(preview.visible) { preview.hide(); }
				var sprite:Sprite = createOldPictureSprite(pictureData);
				sprite.x = 100;
				sprite.y = 100;
				addChild(sprite);
			});
			
			remotePicture.addEventListener(MouseEvent.ROLL_OVER, function(e:MouseEvent):void {
				if(map != null) { map.showPictureLocation(pictureData); }
				
				var previewX:int = remotePicture.x + remotePicture.width / 2;
				var previewY:int = HEIGHT + MARGIN;
				
				if(!preview.visible) { preview.show(new Point(previewX, previewY)); }
				else { preview.move(new Point(previewX, previewY)); }
				preview.loadPicture(pictureData);
			});
			
			remotePicture.addEventListener(MouseEvent.ROLL_OUT, function(e:MouseEvent):void {
				//if(map != null) { map.clearPictureLocation(); }
			});
			return remotePicture;
		}
		
		public function show():void {
			if(visible) { return; }
			visible = true;
			tween = new Tween(this, "y", Strong.easeOut, HEIGHT * -1, 0, 0.25, true);
		}
		
		public function hide():void {
			if(!visible) { return; }
			tween = new Tween(this, "y", Strong.easeOut, this.y, HEIGHT * -1, 0.25, true);
			setTimeout(function():void { visible = false; }, 250);
		}
	}
}
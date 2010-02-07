package mumble.timerou.map.display
{
	import fl.transitions.Tween;
	import fl.transitions.easing.Strong;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	
	import mumble.timerou.map.data.PictureData;
	import mumble.timerou.map.data.RemotePicture;

	public class Preview extends Sprite
	{
		private const INITIAL_WIDTH:int = 200;
		private const INITIAL_HEIGHT:int = 200; 
		private const BACKGROUND_COLOR:uint = 0x333333;
		private const BORDER_COLOR:uint = 0x555555;
		private const PADDING:int = 5;
		
		public var pictureData:PictureData = null;
		
		private var remotePicture:RemotePicture = null;
		private var position:Point = null;
		private var tween:Tween = null;
		private var showTween:Tween = null;
		
		public function Preview() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			drawBox();
			this.visible = false; //starts invisible
			
			filters = [ new DropShadowFilter() ];
		}
		
		private function drawBox():void {
			var correctWidth:int = INITIAL_WIDTH + PADDING * 2;
			var correctHeight:int = INITIAL_HEIGHT + PADDING * 2;
			
			graphics.clear();
			graphics.beginFill(BACKGROUND_COLOR);
			graphics.lineStyle(1, BORDER_COLOR);
			graphics.drawRect(0, 0, correctWidth, correctHeight);
			graphics.endFill();
		}
		
		private function drawPicture():void {
			if(remotePicture != null) {
				removeChild(remotePicture);
			}
			remotePicture = new RemotePicture(Main.BASEPICTURESURL + pictureData.optimizedPath, INITIAL_WIDTH, INITIAL_HEIGHT, true);
			remotePicture.x = PADDING;
			remotePicture.y = PADDING;
			addChild(remotePicture);
			remotePicture.addEventListener(RemotePicture.LOAD_COMPLETE, function(e:Event):void { 
				adjustSize();
			});
		}
		
		public function loadPicture(pictureData:PictureData):void {
			this.pictureData = pictureData;
			drawPicture();
		}
		
		public function move(position:Point):void {
			this.position = position;
			this.y = position.y
			if(tween != null) {
				if(tween.isPlaying) { tween.stop(); }
			}
			
			var newX:int = position.x - (this.width / 2);
			
			if(newX < 0) {
				newX = 0;
			} else {
				var overflowX:int = (newX + this.width) - stage.stageWidth;
				if(overflowX > 0) {
					newX = stage.stageWidth - this.width;
				}
			}
			
			tween = new Tween(this, "x", Strong.easeOut, this.x, newX, 0.5, true);
		}
		
		private function adjustSize():void {
			if(this.remotePicture == null) {
				return;
			}
			
			var newWidth:int = this.remotePicture.width + (PADDING * 2);
			var newHeight:int = this.remotePicture.height + (PADDING * 2);
			
			tween = new Tween(this, "width", Strong.easeOut, this.width, newWidth, 0.25, true);
			tween = new Tween(this, "height", Strong.easeOut, this.height, newHeight, 0.25, true);
		}
		
		public function show(position:Point):void {
			if(visible) { return; }
			visible = true;
			showTween = new Tween(this, "alpha", Strong.easeOut, 0, 1, 0.25, true);
			move(position);
		}
		
		public function hide():void {
			if(!visible) { return; }
			showTween = new Tween(this, "alpha", Strong.easeOut, 1, 0, 0.25, true);
			setTimeout(function():void { visible = false; }, 250);
		}
	}
}

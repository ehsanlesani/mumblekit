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
		private const MARKER_SIZE:int = 6;
		
		private const MARKER_EDGE_TOP:int = 1;
		private const MARKER_EDGE_LEFT:int = 2;
		private const MARKER_EDGE_BOTTOM:int = 3;
		private const MARKER_EDGE_RIGHT:int = 4;
		
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
			
			//get max space and select best edge
			var spaceRight:int = stage.stageWidth - position.x;
			var spaceLeft:int = stage.stageWidth - spaceRight;
			var spaceBottom:int = stage.stageHeight - position.y;
			var spaceTop:int = stage.stageHeight - spaceBottom;
			
			var possibilities:Array = [ 
				{ value: spaceRight, marker: MARKER_EDGE_LEFT },
				{ value: spaceLeft, marker: MARKER_EDGE_RIGHT },
				{ value: spaceBottom, marker: MARKER_EDGE_TOP },
			 	{ value: spaceTop, marker: MARKER_EDGE_BOTTOM }
			];
			
			var markerEdge:int = possibilities[0].marker;			
			var lastPossibility:* = possibilities[0];
			for each(var possibility:* in possibilities) {
				if(lastPossibility.value < possibility.value) { markerEdge = possibility.marker; }
			}
			
			var rectX:int = 0;
			var rectY:int = 0;
			
			if(markerEdge == MARKER_EDGE_TOP || markerEdge == MARKER_EDGE_BOTTOM) {
				rectX = position.x - INITIAL_WIDTH / 2 + MARKER_SIZE;
				if(rectX < 0) {
					rectX = 0;
				} else if(rectX + INITIAL_WIDTH > stage.stageWidth) {
					rectX = stage.stageWidth - INITIAL_WIDTH;
				}
				
				if(markerEdge == MARKER_EDGE_TOP) {
					rectY = position.y + MARKER_SIZE;
				} else {
					rectY = position.y - MARKER_SIZE - INITIAL_HEIGHT;
				}
			} else if(markerEdge == MARKER_EDGE_LEFT || markerEdge == MARKER_EDGE_RIGHT) {
				rectY = position.y - INITIAL_HEIGHT / 2 + MARKER_SIZE;
				if(rectY < 0) {
					rectY = 0;
				} else if(rectY + INITIAL_HEIGHT > stage.stageHeight) {
					rectY = stage.stageHeight - INITIAL_HEIGHT;
				}
				
				if(markerEdge == MARKER_EDGE_LEFT) {
					rectX = position.x + MARKER_SIZE;
				} else {
					rectX = position.x - INITIAL_WIDTH - MARKER_SIZE;
				}
			}
			
			trace(markerEdge);
			
			graphics.clear();
			graphics.beginFill(BACKGROUND_COLOR);
			graphics.drawRect(rectX, rectY, INITIAL_WIDTH, INITIAL_HEIGHT);
			graphics.endFill();
			//tween = new Tween(this, "x", Strong.easeOut, this.x, newX, 0.5, true);
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

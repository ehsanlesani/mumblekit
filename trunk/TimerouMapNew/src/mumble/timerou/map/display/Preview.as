package mumble.timerou.map.display
{
	import fl.transitions.TransitionManager;
	import fl.transitions.Tween;
	import fl.transitions.easing.Strong;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	
	import mumble.timerou.map.data.PictureData;
	import mumble.timerou.map.data.RemotePicture;

	public class Preview extends MovieClip
	{
		public static const MOVE_COMPLETE:String = "move_complete";
		
		private const INITIAL_WIDTH:int = 200;
		private const INITIAL_HEIGHT:int = 200; 
		private const BACKGROUND_COLOR:uint = 0x333333;
		private const BACKGROUND_ALPHA:Number = 0.50;
		private const BORDER_COLOR:uint = 0xFFFFFF;
		private const BORDER_THICKNESS:int = 3;
		private const PADDING:int = 5;
		private const MARKER_SIZE:int = 10;
		private const MARGIN_BOTTOM:int = 60;
		
		private const MARKER_EDGE_TOP:int = 1;
		private const MARKER_EDGE_LEFT:int = 2;
		private const MARKER_EDGE_BOTTOM:int = 3;
		private const MARKER_EDGE_RIGHT:int = 4;
		
		public var pictureData:PictureData = null;	
		
		private var remotePicture:RemotePicture = null;
		private var tweenX:Tween = null;
		private var tweenY:Tween = null;
		private var showTween:Tween = null;
		private var pictureFadeTween:Tween = null;
		private var transitionManager:TransitionManager = null;
		private var position:Point = new Point();
		private var markerEdge:int = 0;
		private var rectX:Number = 0;
		private var rectY:Number = 0;
		private var hiding:Boolean = false;
		
		public function Preview() {
			transitionManager = new TransitionManager(this);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			this.visible = false; //starts invisible
			
			filters = [ new DropShadowFilter(0, 0, 0, 1, 5, 5, 1, 1) ];
		}
		
		private function drawBox():void {
			
			//get max space and select best edge
			var spaceRight:Number = stage.stageWidth - position.x;
			var spaceLeft:Number = stage.stageWidth - spaceRight;
			var spaceBottom:Number = stage.stageHeight - position.y;
			var spaceTop:Number = stage.stageHeight - spaceBottom;
			
			var possibilities:Array = [ 
				{ value: spaceRight, marker: MARKER_EDGE_LEFT },
				{ value: spaceLeft, marker: MARKER_EDGE_RIGHT },
				{ value: spaceBottom, marker: MARKER_EDGE_TOP },
			 	{ value: spaceTop, marker: MARKER_EDGE_BOTTOM }
			];
			
			markerEdge = possibilities[0].marker;			
			var bestPossibility:* = possibilities[0];
			for each(var possibility:* in possibilities) {
				if(bestPossibility.value < possibility.value) { markerEdge = possibility.marker; bestPossibility = possibility; }
			}
			
			if(markerEdge == MARKER_EDGE_TOP || markerEdge == MARKER_EDGE_BOTTOM) {
				rectX = position.x - INITIAL_WIDTH / 2;
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
				rectY = position.y - INITIAL_HEIGHT / 2;
				if(rectY < 0) {
					rectY = 0;
				} else if(rectY + INITIAL_HEIGHT > stage.stageHeight - MARGIN_BOTTOM) {
					rectY = stage.stageHeight - INITIAL_HEIGHT - MARGIN_BOTTOM;
				}
				
				if(markerEdge == MARKER_EDGE_LEFT) {
					rectX = position.x + MARKER_SIZE;
				} else {
					rectX = position.x - INITIAL_WIDTH - MARKER_SIZE;
				}
			}			
						
			graphics.clear();
			graphics.endFill();
			graphics.beginFill(BACKGROUND_COLOR, BACKGROUND_ALPHA);
			graphics.lineStyle(BORDER_THICKNESS, BORDER_COLOR);
						
			/*if(markerEdge == MARKER_EDGE_LEFT) {
				graphics.moveTo(position.x, position.y);
				graphics.lineTo(rectX, position.y + MARKER_SIZE);
				graphics.lineTo(rectX, rectY + INITIAL_HEIGHT);
				graphics.lineTo(rectX + INITIAL_WIDTH, rectY + INITIAL_HEIGHT);
				graphics.lineTo(rectX + INITIAL_WIDTH, rectY);
				graphics.lineTo(rectX, rectY);
				graphics.lineTo(rectX, position.y - MARKER_SIZE);
			} else if (markerEdge == MARKER_EDGE_RIGHT) {
				graphics.moveTo(position.x, position.y);
				graphics.lineTo(rectX + INITIAL_WIDTH, position.y - MARKER_SIZE);
				graphics.lineTo(rectX + INITIAL_WIDTH, rectY);
				graphics.lineTo(rectX, rectY);
				graphics.lineTo(rectX, rectY + INITIAL_HEIGHT);
				graphics.lineTo(rectX + INITIAL_WIDTH, rectY + INITIAL_HEIGHT);
				graphics.lineTo(rectX + INITIAL_WIDTH, position.y + MARKER_SIZE);
			} else if (markerEdge == MARKER_EDGE_TOP) {
				graphics.moveTo(position.x, position.y);
				graphics.lineTo(rectX - MARKER_SIZE, rectY);
				graphics.lineTo(rectX, rectY);
				graphics.lineTo(rectX, rectY + INITIAL_HEIGHT);
				graphics.lineTo(rectX + INITIAL_WIDTH, rectY + INITIAL_HEIGHT);
				graphics.lineTo(rectX + INITIAL_WIDTH, rectY);
				graphics.lineTo(rectX + MARKER_SIZE, rectY) 
			} else if (markerEdge == MARKER_EDGE_BOTTOM) {
				graphics.moveTo(position.x, position.y);
				graphics.lineTo(position.x + MARKER_SIZE, rectY + INITIAL_HEIGHT);
				graphics.lineTo(rectX + INITIAL_WIDTH, rectY + INITIAL_HEIGHT);
				graphics.lineTo(rectX + INITIAL_WIDTH, rectY);
				graphics.lineTo(rectX, rectY);
				graphics.lineTo(rectX, rectY + INITIAL_HEIGHT);
				graphics.lineTo(position.x - MARKER_SIZE, rectY + INITIAL_HEIGHT);
			}*/
			
			rectX -= position.x;
			rectY -= position.y;
			
			if(markerEdge == MARKER_EDGE_LEFT) {
				graphics.moveTo(0, 0);
				graphics.lineTo(rectX, 0 + MARKER_SIZE);
				graphics.lineTo(rectX, rectY + INITIAL_HEIGHT);
				graphics.lineTo(rectX + INITIAL_WIDTH, rectY + INITIAL_HEIGHT);
				graphics.lineTo(rectX + INITIAL_WIDTH, rectY);
				graphics.lineTo(rectX, rectY);
				graphics.lineTo(rectX, 0 - MARKER_SIZE);
			} else if (markerEdge == MARKER_EDGE_RIGHT) {
				graphics.moveTo(0, 0);
				graphics.lineTo(rectX + INITIAL_WIDTH, 0 - MARKER_SIZE);
				graphics.lineTo(rectX + INITIAL_WIDTH, rectY);
				graphics.lineTo(rectX, rectY);
				graphics.lineTo(rectX, rectY + INITIAL_HEIGHT);
				graphics.lineTo(rectX + INITIAL_WIDTH, rectY + INITIAL_HEIGHT);
				graphics.lineTo(rectX + INITIAL_WIDTH, 0 + MARKER_SIZE);
			} else if (markerEdge == MARKER_EDGE_TOP) {
				graphics.moveTo(0, 0);
				graphics.lineTo(0 - MARKER_SIZE, rectY);
				graphics.lineTo(rectX, rectY);
				graphics.lineTo(rectX, rectY + INITIAL_HEIGHT);
				graphics.lineTo(rectX + INITIAL_WIDTH, rectY + INITIAL_HEIGHT);
				graphics.lineTo(rectX + INITIAL_WIDTH, rectY);
				graphics.lineTo(0 + MARKER_SIZE, rectY) 
			} else if (markerEdge == MARKER_EDGE_BOTTOM) {
				graphics.moveTo(0, 0);
				graphics.lineTo(0 + MARKER_SIZE, rectY + INITIAL_HEIGHT);
				graphics.lineTo(rectX + INITIAL_WIDTH, rectY + INITIAL_HEIGHT);
				graphics.lineTo(rectX + INITIAL_WIDTH, rectY);
				graphics.lineTo(rectX, rectY);
				graphics.lineTo(rectX, rectY + INITIAL_HEIGHT);
				graphics.lineTo(0 - MARKER_SIZE, rectY + INITIAL_HEIGHT);
			}
			
			graphics.endFill();

		}
		
		private function drawPicture():void {
			if(pictureFadeTween != null && pictureFadeTween.isPlaying) { pictureFadeTween.stop(); }

			if(remotePicture != null) {
				remotePicture.unload();
				removeChild(remotePicture);				
			}
			remotePicture = new RemotePicture(Main.BASEPICTURESURL + pictureData.optimizedPath, INITIAL_WIDTH - PADDING * 2, INITIAL_HEIGHT - PADDING * 2, true);
			remotePicture.x = rectX + PADDING;
			remotePicture.y = rectY + PADDING;
			remotePicture.showBorder = false;
			addChild(remotePicture);
			remotePicture.addEventListener(RemotePicture.LOAD_COMPLETE, function(e:Event):void { 
				pictureFadeTween = new Tween(remotePicture, "alpha", Strong.easeOut, 0, 1, 0.25, true);
			});
		}
		
		public function loadPicture(pictureData:PictureData):void {
			this.pictureData = pictureData;
			drawPicture();
		}

		public function move(position:Point):void {
			this.position = position;			
			drawBox();
			
			if(tweenX != null && tweenX.isPlaying) { tweenX.stop(); }
			if(tweenY != null && tweenY.isPlaying) { tweenY.stop(); }
						
			var duration:Number = 0.5;
						
			tweenX = new Tween(this, "x", Strong.easeOut, this.x, position.x, duration, true);
			tweenY = new Tween(this, "y", Strong.easeOut, this.y, position.y, duration, true);
			
			setTimeout(function():void { if(!hiding && visible) { dispatchEvent(new Event(MOVE_COMPLETE)); } }, duration * 1000);
		}
		
		public function show(position:Point):void {
			if(visible) { return; }
			visible = true;
			hiding = false;
			showTween = new Tween(this, "alpha", Strong.easeOut, 0, 1, 0.25, true);
			move(position);
		}
		
		public function hide():void {
			if(!visible) { return; }
			hiding = true;
			showTween = new Tween(this, "alpha", Strong.easeOut, 1, 0, 0.25, true);
			setTimeout(function():void { visible = false; hiding = false; }, 250);
		}
	}
}

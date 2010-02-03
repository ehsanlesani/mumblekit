package
{
	import fl.transitions.Fade;
	import fl.transitions.Transition;
	import fl.transitions.TransitionManager;
	import fl.transitions.easing.Strong;
	
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	
	public class MediaContainer extends MovieClip
	{
		public const DISPLAY_MAXIMIZED:int = 0;
		public const DISPLAY_MINIMIZED:int = 1;
		
		private const MINIMIZED_WIDTH:int = 120;
		private const MINIMIZED_HEIGHT:int = 100;
		private const BACKGROUND_COLOR:uint = 0xFFFFFF;
		private const BACKGROUND_ALPHA:Number = 1;
		private const ROUND_SIZE:int = 10;
		
		private var displayMode:int = DISPLAY_MINIMIZED;
		private var contentRectangle:Shape = null;
		private var enterTransition:TransitionManager = null;
		private var pictures:Array = null;
	
		public function MediaContainer() {
			this.contentRectangle = new Shape();
			this.enterTransition = new TransitionManager(this);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			stage.addEventListener(Event.RESIZE, onStageResize);	
					
			this.contentRectangle = new Shape();	
			addChild(this.contentRectangle);		
			drawContentRectangle();				
			
			//this.visible = false;
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
				g.moveTo(0, 0),
				g.lineTo(MINIMIZED_WIDTH, 0);
				g.lineTo(MINIMIZED_WIDTH, MINIMIZED_HEIGHT - ROUND_SIZE);
				g.curveTo(MINIMIZED_WIDTH, MINIMIZED_HEIGHT, MINIMIZED_WIDTH - ROUND_SIZE, MINIMIZED_HEIGHT);
				g.lineTo(0, MINIMIZED_HEIGHT);
			}
		}
		
		public function show():void {
			this.visible = true;
			this.enterTransition.startTransition({type:Fade, direction:Transition.IN, duration:0.5, easing:Strong.easeOut});
		}
		
		public function hide():void {
			this.removeAllPictures(); //clear
			this.visible = false;
		}
		
		public function load(pictures:Array):void {
			if(pictures.length > 0)
			{
				this.pictures = pictures;
				var pb:PictureBox = new PictureBox();
				pb.url = "http://localhost:1095/Pictures/" + this.pictures[0].avatarPath;
				
				addChild(pb);
				pb.x = 5;
				pb.y = 5;
			}
		}
		
		public function changeDisplayMode(displayMode:int):void {
			this.displayMode = displayMode;
		}
		
	}
}

	
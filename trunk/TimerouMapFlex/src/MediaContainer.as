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
	
	public class MediaContainer extends MovieClip
	{
		private const BACKGROUND_COLOR:uint = 0x333333;
		private const BACKGROUND_ALPHA:Number = 0.90;
		private const BORDER_DISTANCE:int = 25;
		private const ROUND_SIZE:int = 5;
		
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
			
			drawContentRectangle();				
			
			this.visible = false;
		}
		
		private function onStageResize(e:Event):void {
			drawContentRectangle();	
		}
		
		private function drawContentRectangle():void {
			var height:Number = stage.stageHeight - (BORDER_DISTANCE * 2);
			var width:Number = stage.stageWidth - (BORDER_DISTANCE * 2);

			var g:Graphics = this.contentRectangle.graphics;
			g.clear();
			g.beginFill(BACKGROUND_COLOR, BACKGROUND_ALPHA);
			g.drawRoundRect(BORDER_DISTANCE, BORDER_DISTANCE, width, height, ROUND_SIZE, ROUND_SIZE);
			
			this.addChild(this.contentRectangle);
		}
		
		public function show():void {
			this.visible = true;
			this.enterTransition.startTransition({type:Fade, direction:Transition.IN, duration:0.5, easing:Strong.easeOut});
		}
		
		public function hide():void {
			this.visible = false;
		}
		
		public function load(pictures:Array):void {
			this.pictures = pictures;
			
		}
		 
		
	}
}
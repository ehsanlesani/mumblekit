package mumble.timerou.map.display
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Border extends Sprite {
		
		public function Border() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			drawBorder();
			
			stage.addEventListener(Event.RESIZE, drawBorder);	
		}
		
		private function drawBorder(e:Event = null):void {
			graphics.clear();
			graphics.lineStyle(2, 0xE1E1E1);
			graphics.drawRoundRect(0, 0, stage.stageWidth, stage.stageHeight, 15, 15);
		}
	}
}
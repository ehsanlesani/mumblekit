package mumble.timerou.timebar.display
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Loading extends MovieClip {
		
		private var hoursTheta:Number = 0;
		private var minutesTheta:Number = 0;
		private var minutesVel:Number = 0.3;
		private var hoursVel:Number = minutesVel / 12;
		
		public function Loading()  {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void {
			var initialMX:Number = 0;
			var initialMY:Number = -6;
			var initialHX:Number = 0;
			var initialHY:Number = -4;
			
			hoursTheta += hoursVel;
			minutesTheta += minutesVel;
			var mx:Number = Math.cos(minutesTheta) * initialMX - Math.sin(minutesTheta) * initialMY;
			var my:Number = Math.sin(minutesTheta) * initialMX + Math.cos(minutesTheta) * initialMY;
			var hx:Number = Math.cos(hoursTheta) * initialHX - Math.sin(hoursTheta) * initialHY;
			var hy:Number = Math.sin(hoursTheta) * initialHX + Math.cos(hoursTheta) * initialHY;
			
			graphics.clear();
			graphics.beginFill(0x111111);
			graphics.lineStyle(2, 0xC1BFD9);
			graphics.drawCircle(0, 0, 8);
			graphics.endFill();
			graphics.lineStyle(1, 0xFFFFFF);
			graphics.moveTo(0, 0);
			graphics.lineTo(mx, my);
			graphics.lineStyle(1, 0xFFFFFF);
			graphics.moveTo(0, 0);
			graphics.lineTo(hx, hy);
		}
	}
}
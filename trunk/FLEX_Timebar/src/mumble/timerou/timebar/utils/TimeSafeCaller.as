package mumble.timerou.timebar.utils
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class TimeSafeCaller
	{
		private static const delay:int = 1000;
		private static var callingFunctions:Array = new Array();
		
		public static function call(identifier:String, fn:Function):void {
			var cf:CallingFunction = getCallingFunction(identifier);
			if(cf == null) {
				trace("Crated caller: " + identifier);
				var timer:Timer = new Timer(delay, 1);
				timer.addEventListener(TimerEvent.TIMER, function(e:TimerEvent):void { 
					deleteFunction(cf);
					fn();
				});  
				cf = new CallingFunction(identifier, fn, timer, delay);
				callingFunctions.push(cf);
			}
			
			cf.timer.stop();
			cf.timer.start();
		}
		
		private static function deleteFunction(cf:CallingFunction):void {
			var index:int = callingFunctions.indexOf(cf);
			callingFunctions = callingFunctions.splice(index, 1);			
		}
		
		private static function getCallingFunction(identifier:String):CallingFunction {
			for each(var cf:CallingFunction in callingFunctions) {
				if(cf.identifier == identifier) { return cf; }
			}
			return null;
		}

	}
}
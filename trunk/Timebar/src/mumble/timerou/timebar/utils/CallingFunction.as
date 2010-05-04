package mumble.timerou.timebar.utils
{
	import flash.utils.Timer;
	
	public class CallingFunction
	{
		public var identifier:String = null;
		public var fn:Function = null;
		public var timer:Timer = null;
		public var delay:int = 1000;
		
		public function CallingFunction(identifier:String, fn:Function, timer:Timer, delay:int) {
			this.identifier = identifier;
			this.fn = fn;
			this.timer = timer;
			this.delay = delay;
		}

	}
}
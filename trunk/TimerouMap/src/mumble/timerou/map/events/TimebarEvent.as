package mumble.timerou.map.events
{
	import flash.events.Event;

	public class TimebarEvent extends Event
	{
		public static const YEAR_CHANGED:String = "yearChanged";
		public static const SHOW_MEDIA_LOCATIONS:String = "showMediaLocations";
		
		public var year:int = 0;
		public var mediasData:Array;
		
		public function TimebarEvent(type:String) {
			super(type);
		}		
	}
}
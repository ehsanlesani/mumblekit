package mumble.timerou.map.events
{
	import flash.events.Event;

	public class TimebarEvent extends Event
	{
		public static const YEAR_CHANGED:String = "yearChanged";
		public static const SHOW_MEDIA_LOCATIONS:String = "showMediaLocations";
		public static const SHOW_PREVIEW:String = "showPreview";
		public static const HIDE_PREVIEW:String = "hidePreview";
		
		public var year:int = 0;
		public var mediasData:Array;
		public var id:String;
		
		public function TimebarEvent(type:String) {
			super(type);
		}		
	}
}
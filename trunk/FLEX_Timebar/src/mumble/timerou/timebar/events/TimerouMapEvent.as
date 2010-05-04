package mumble.timerou.timebar.events
{
	import com.google.maps.LatLngBounds;
	
	import flash.events.Event;
	
	public class TimerouMapEvent extends Event
	{
		public static const BOUNDS_CHANGED:String = "boundsChanged";
	
		public var bounds:LatLngBounds = null;
	
		public function TimerouMapEvent(type:String) {
			super(type);			
		}
	}
}
package mumble.timerou.map.net
{
	import com.google.maps.LatLngBounds;
	
	import flash.net.LocalConnection;
	
	import mumble.timerou.map.events.TimebarEvent;
	
	public class TimebarConnection extends LocalConnection
	{
		private const remoteConnectionName:String = "timebar";
		private const localConnectionName:String = "map";
		
		public function TimebarConnection() {
			try {
				connect(localConnectionName);
			} catch(err:Error) {
				trace(err);
			}	
		}
		
		public function setBounds(bounds:LatLngBounds):void {
			try {
				send(remoteConnectionName, "onMapMoveEnd", bounds.getSouthWest().lat(), bounds.getSouthWest().lng(), bounds.getNorthEast().lat(), bounds.getNorthEast().lng());
			} catch(err:Error) {
				trace(err);
			}
		}
		
		//event handling
		
		public function onYearChanged(year:int):void {
			var event:TimebarEvent = new TimebarEvent(TimebarEvent.YEAR_CHANGED);
			event.year = year;
			dispatchEvent(event);
		}
		
		public function onShowMediasLocations(mediasData:Array):void {
			var event:TimebarEvent = new TimebarEvent(TimebarEvent.SHOW_MEDIA_LOCATIONS);
			event.mediasData = mediasData;
			dispatchEvent(event);
		}
	}
}
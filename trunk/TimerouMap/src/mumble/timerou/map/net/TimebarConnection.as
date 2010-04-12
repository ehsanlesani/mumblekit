package mumble.timerou.map.net
{
	import com.google.maps.LatLngBounds;
	
	import flash.net.LocalConnection;
	
	import mumble.timerou.map.data.MediaData;
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
		
		public function onShowMediaLocations(mediasData:Array):void {
			var event:TimebarEvent = new TimebarEvent(TimebarEvent.SHOW_MEDIA_LOCATIONS);
			
			var data:Array = new Array();
			for each(var source:* in mediasData) {
				data.push(new MediaData(source));
			}
			
			event.mediasData = data;
			dispatchEvent(event);
		}
		
		public function onShowPreview(id:String):void {
			var event:TimebarEvent = new TimebarEvent(TimebarEvent.SHOW_PREVIEW);
			event.id = id;
			dispatchEvent(event);
		}
		
		public function onHidePreview():void {
			var event:TimebarEvent = new TimebarEvent(TimebarEvent.HIDE_PREVIEW);
			dispatchEvent(event);
		}
	}
}
package mumble.timerou.timebar.net
{
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	
	import flash.net.LocalConnection;
	
	import mumble.timerou.timebar.events.TimerouMapEvent;
	
	public class MapConnection extends LocalConnection
	{ 
		private const remoteConnectionName:String = "map";
		private const localConnectionName:String = "timebar";
		
		public function MapConnection() {
			try {
				connect(localConnectionName);
			} catch(err:Error) {
				trace(err);
			}	
		}
		
		public function setYear(year:int):void {
			try {
				send(remoteConnectionName, "onYearChanged", year);
			} catch(err:Error) {
				trace(err);
			}
		}
		
		public function showMediaLocations(mediasData:Array):void {
			try {
				send(remoteConnectionName, "onShowMediaLocations", mediasData);
			} catch(err:Error) {
				trace(err);
			}
		}
		
		public function showPreview(id:String):void {
			try {
				send(remoteConnectionName, "onShowPreview", id);
			} catch(err:Error) {
				trace(err);
			}
		}
		
		public function hidePreview():void {
			try {
				send(remoteConnectionName, "onHidePreview");
			} catch(err:Error) {
				trace(err);
			}
		}
		
		
		//events handling
		
		public function onMapMoveEnd(swlat:Number, swlng:Number, nelat:Number, nelng:Number):void {
			var event:TimerouMapEvent = new TimerouMapEvent(TimerouMapEvent.BOUNDS_CHANGED);
			event.bounds = new LatLngBounds(new LatLng(swlat, swlng), new LatLng(nelat, nelng));
			dispatchEvent(event);
		}

	}
}
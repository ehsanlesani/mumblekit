package mumble.timerou.timebar.data
{
	import com.google.maps.LatLngBounds;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	public class PerYearMediaDataLoader extends EventDispatcher
	{
		public static const DIRECTION_FORWARD:String = "Forward";
		public static const DIRECTION_BACK:String = "Back";
		
		public var response:YearGroupedMediasResponse = null;
		
		public function PerYearMediaDataLoader()
		{
		}

		public function load(bounds:LatLngBounds, mediasToLoad:int, referenceYear:int, direction:String):void {
			try 
			{
				var request:URLRequest = new URLRequest(Main.LOAD_PERYEAR_SERVICE_URL);
				request.method = URLRequestMethod.POST;
				var variables:URLVariables = new URLVariables();			
				variables.swlat = bounds.getSouthWest().lat();
				variables.swlng = bounds.getSouthWest().lng(); 
				variables.nelat = bounds.getNorthEast().lat();
				variables.nelng = bounds.getNorthEast().lng();
				variables.mediasToLoad = mediasToLoad;
				variables.referenceYear = referenceYear;
				variables.direction = direction;
				request.data = variables;
				var loader:URLLoader = new URLLoader();
				loader.addEventListener(Event.COMPLETE, function(e:Event):void { 
					setMediasData(e.target.data);
					dispatchEvent(new Event(Event.COMPLETE));
				});
				loader.load(request);
			}
			catch (err:Error)
			{
				trace(err);
			}
		}
		
		private function setMediasData(jsonData:String):void {
			var result:* = JSON.deserialize(jsonData);
			response = new YearGroupedMediasResponse(result);			
		}		
	}
}
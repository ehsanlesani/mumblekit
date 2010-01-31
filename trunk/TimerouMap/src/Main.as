package 
{
	import com.google.maps.LatLngBounds;
	import com.google.maps.MapEvent;
	import com.serialization.json.JSON;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	
	/**
	 * ...
	 * @author bruno
	 */
	public class Main extends MovieClip 
	{
		private var pictureData:* = null;		
		private var map:TimerouMap = null;
		
		public function Main():void 
		{
			ConfigureExternalInterface();

			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function ConfigureExternalInterface():void {
			if (ExternalInterface.available) {
				ExternalInterface.addCallback("setPicturesData", setPicturesData);				
			}
		}
		
		private function init(e:Event = null):void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			this.map = new TimerouMap();
			addChild(map);
			
			map.addEventListener("timerouMapReady", mapReady);
			map.addEventListener("timerouMapMove", mapMove);
		}
		
		private function mapMove(e:Event):void {
			loadPictures();
		}
		
		private function mapReady(e:Event):void {
			var vel:int = 1;
			addEventListener(Event.ENTER_FRAME, function(e:Event):void { 
					if(map.ready) {
						if (map.oldStyle <= 0 || map.oldStyle >= 100) { vel *= -1; }
						map.oldStyle += vel;
						//trace("value:" + map.oldStyle + " vel: " + vel);
						
					}
				} );
		}
		
		private function loadPictures():void {
			try 
			{
				var bounds:LatLngBounds = map.latLngBounds;
				
				var request:URLRequest = new URLRequest("http://localhost:1095/Map/LoadPictures");
				request.method = URLRequestMethod.POST;
				var variables :URLVariables = new URLVariables();			
				variables.lat1 = bounds.getNorthWest().lat();
				variables.lng1 = bounds.getNorthWest().lng(); 
				variables.lat2 = bounds.getSouthEast().lat();
				variables.lng2 = bounds.getSouthEast().lng();
				variables.year = 2010;
				request.data = variables;
				var loader:URLLoader = new URLLoader();
				loader.addEventListener(Event.COMPLETE, function(e:Event):void { 
					setPicturesData(e.target.data);
				});
				loader.load(request);
			}
			catch (err:Error)
			{
				trace(err);
			}
		}
		
		public function setPicturesData(jsonData:String):void {
			this.pictureData = JSON.deserialize(jsonData);
			if (!pictureData.error) {
				map.addPictures(pictureData.pictures);
			}
		}		
	}	
}
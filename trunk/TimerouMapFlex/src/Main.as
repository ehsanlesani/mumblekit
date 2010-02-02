package 
{
	import com.google.maps.LatLngBounds;
	import com.serialization.json.JSON;
	
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	
	/**
	 * ...
	 * @author bruno
	 */
	
	[SWF(height = 600, width = 800)]
	public class Main extends MovieClip 
	{
		private var pictureData:* = null;		
		private var map:TimerouMap = null;
		private var mediaContainer:MediaContainer = null;
		private var mapMoveTimer:Timer = null;
		
		public function Main():void 
		{
			ConfigureExternalInterface();
			mapMoveTimer = new Timer(1000, 1);
			mapMoveTimer.addEventListener(TimerEvent.TIMER_COMPLETE, mapMoveTimerComplete);

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
			this.mediaContainer = new MediaContainer();
			
			addChild(map);
			addChild(mediaContainer);
			
			//map.addEventListener("timerouMapReady", mapReady);
			map.addEventListener("timerouMapMoveStart", mapMoveStart);
			map.addEventListener("timerouMapMoveEnd", mapMoveEnd);
		}
		
		private function mapMoveTimerComplete(e:TimerEvent):void {
			this.mediaContainer.show();
			this.map.hideTypeButtons();
		}
		
		private function mapMoveStart(e:Event):void {
			this.mapMoveTimer.stop();
			this.map.showTypeButtons();
			this.mediaContainer.hide();
		}
		
		private function mapMoveEnd(e:Event):void {
			this.mapMoveTimer.stop();
			this.mapMoveTimer.start();
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
				trace(bounds);
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
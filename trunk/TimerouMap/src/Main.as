package
{
	import com.google.maps.LatLngBounds;
	
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
	
	import mumble.timerou.map.data.JSON;
	import mumble.timerou.map.data.PictureData;
	import mumble.timerou.map.display.MediaContainer;
	import mumble.timerou.map.display.MiniSlideshow;
	import mumble.timerou.map.display.TimerouMap;
	
	
	/**
	 * ...
	 * @author bruno
	 */
	
	[SWF(height = 600, width = 800)]
	public class Main extends MovieClip 
	{
		public static const BASEURL:String = "http://localhost:1095/Pictures/";
		
		private var map:TimerouMap = null;
		private var miniSlideshow:MiniSlideshow = null;
		private var mapMoveTimer:Timer = null;
		private var pictures:Array = new Array();
		
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
			this.miniSlideshow = new MiniSlideshow();
			this.miniSlideshow.addEventListener("slideshowChanged", showPictureOnMap);
			
			addChild(map);
			addChild(miniSlideshow);
			addChild(new MediaContainer());
			
			//map.addEventListener("timerouMapReady", mapReady);
			map.addEventListener("timerouMapMoveStart", mapMoveStart);
			map.addEventListener("timerouMapMoveEnd", mapMoveEnd);
		}
		
		private function showPictureOnMap(e:Event):void {
			var pictureData:* = this.miniSlideshow.getCurrentSlideshowPicture();
			if(pictureData != null) {
				this.map.showPictureLocation(pictureData);
			}
		}
		
		private function mapMoveTimerComplete(e:TimerEvent):void {
			this.loadPictures();
		}
		
		private function mapMoveStart(e:Event):void {
			this.map.clearPictureLocation();
			this.miniSlideshow.hide();
			this.mapMoveTimer.stop();
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
			var result:* = JSON.deserialize(jsonData);
			if (result != null && !result.error) {
				//load as known objects
				this.pictures = new Array();
				for(var i:int = 0; i < result.pictures.length; i++) {
					this.pictures.push(new PictureData(result.pictures[i]));
				}
				
				//clear current picture location on map
				this.map.clearPictureLocation();

				//and load pictures on media container
				this.miniSlideshow.load(this.pictures);
			}
		}		
	}	
}
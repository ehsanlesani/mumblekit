package
{
	import com.google.maps.LatLngBounds;
	
	import fl.transitions.Tween;
	import fl.transitions.easing.Strong;
	
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
	
	import mumble.timerou.map.data.JSON;
	import mumble.timerou.map.data.PictureData;
	import mumble.timerou.map.display.MediaBar;
	import mumble.timerou.map.display.MediaContainer;
	import mumble.timerou.map.display.TimerouMap;
	
	
	/**
	 * ...
	 * @author bruno
	 */
	
	[SWF(height = 600, width = 800)]
	public class Main extends MovieClip 
	{
		public static var BASEURL:String = "http://localhost:1095/";
		public static var BASEPICTURESURL:String = "http://localhost:1095/Pictures/";
		public static var MAPKEY:String = "ABQIAAAALR8bRKP-XQrzDCAShmrTvxRZcg6rHxTBMZ4Dun_V7KJl7bsRkRTyyWCSl2lWQpqYDZamuBcqyGfb-Q";
		
		private var map:TimerouMap = null;
		private var mediaContainer:MediaContainer = null;
		private var mediaBar:MediaBar = null;
		private var mapMoveTimer:Timer = null;
		private var pictures:Array = new Array();
		private var tween:Tween = null;
		
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
			this.mediaContainer.visible = false;
			
			this.mediaBar = new MediaBar();
			this.mediaBar.visible = false;
			this.mediaBar.map = map;

			addChild(map);
			addChild(mediaBar);
			addChild(mediaContainer);

			//map.addEventListener("timerouMapReady", mapReady);
			map.addEventListener("timerouMapMoveStart", mapMoveStart);
			map.addEventListener("timerouMapMoveEnd", mapMoveEnd);
		}
		
		private function mapMoveTimerComplete(e:TimerEvent):void {
			this.loadPictures();
		}
		
		private function mapMoveStart(e:Event):void {
			this.hideMediaContainer();
			this.mediaBar.hide();
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
		
		private function hideMediaContainer():void {
			var duration:Number = 0.25;
			tween = new Tween(mediaContainer, "x", Strong.easeOut, 0, mediaContainer.width * -1, duration, true);
			tween = new Tween(mediaContainer, "y", Strong.easeOut, 0, mediaContainer.height * -1, duration, true);
			
			setTimeout(function():void { mediaContainer.visible = false; }, duration * 1000);
		}
		
		private function showMediaContainer():void {
			mediaContainer.visible = true;
			var duration:Number = 0.25;
			tween = new Tween(mediaContainer, "x", Strong.easeOut, mediaContainer.x, 0, duration, true);
			tween = new Tween(mediaContainer, "y", Strong.easeOut, mediaContainer.y, 0, duration, true);
		}
		
		public function setPicturesData(jsonData:String):void {
			this.pictures = new Array();
			var result:* = JSON.deserialize(jsonData);
			if (result != null && !result.error) {
				//load as known objects
				for(var  c:int = 0; c < 10; c++)
				for(var i:int = 0; i < result.pictures.length; i++) {
					this.pictures.push(new PictureData(result.pictures[i]));
				}
				
				//and load pictures on media container
				hideMediaContainer();
				this.mediaBar.load(this.pictures);
				this.mediaBar.show();
			}
		}		
		
		public function setPicturesRelatedData(jsonData:String):void {
			this.pictures = new Array();
			var result:* = JSON.deserialize(jsonData);
			if (result != null && !result.error) {
				//load as known objects
				for(var  c:int = 0; c < 10; c++) {
				for(var i:int = 0; i < result.pictures.length; i++) {
					this.pictures.push(new PictureData(result.pictures[i]));
				}
				}				

				//and load pictures on media container
				this.mediaContainer.load(this.pictures);
				showMediaContainer();							
			}
		}		
	}	
}
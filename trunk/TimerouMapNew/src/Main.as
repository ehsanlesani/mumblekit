package
{
	import com.google.maps.LatLngBounds;
	import com.google.maps.MapType;
	
	import fl.transitions.Tween;
	
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	
	import mumble.timerou.map.display.MediaBar;
	import mumble.timerou.map.display.TimerouMap;
	
	
	/**
	 * ...
	 * @author bruno
	 */
	
	[SWF(height = 600, width = 800, backgroundColor = 0xFFFFFF)]
	public class Main extends MovieClip 
	{
		public static var BASEURL:String = "/";
		public static var BASEPICTURESURL:String = BASEURL + "Pictures/";
		public static var LOAD_PICTURE_SERVICE_URL:String = BASEURL + "Map.aspx/LoadPictures";
		public static var MAPKEY:String = "ABQIAAAALR8bRKP-XQrzDCAShmrTvxQb16FdzuBr0nZgkL4aiWmiDXxN7xS6cnax6FiU5Req07YU9Mfy4LamTg";		
		
		private var map:TimerouMap = null;
		private var mediaBar:MediaBar = null;
		private var pictures:Array = new Array();
		private var tween:Tween = null;
		
		public function Main():void 
		{
			ConfigureExternalInterface();
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function ConfigureExternalInterface():void {
			if(ExternalInterface.available) {
				ExternalInterface.addCallback("setYear", setYear);	
				ExternalInterface.addCallback("setBase", setBase);	
				ExternalInterface.addCallback("changeType", changeType);
				ExternalInterface.addCallback("searchLocation", searchLocation);	
				ExternalInterface.addCallback("getMapBounds", getMapBounds);
			}	
		}
		
		private function getMapBounds():* {
			if(map != null) {
				var bounds:LatLngBounds = map.latLngBounds;
				
				return { lat1: bounds.getNorthWest().lat(), lng1: bounds.getNorthWest().lng(), lat2: bounds.getSouthEast().lat(), lng2: bounds.getSouthEast().lng() };
			}
			
			return null;
		}
		
		private function searchLocation(keyword:String):void {
			map.goToLocation(keyword);
		}
		
		private function setBase(base:String):void {
			BASEURL = base;
		}
		
		private function changeType(type:String):void {
			switch(type) {
				case "road":
					map.setMapType(MapType.NORMAL_MAP_TYPE);
					break;
				case "hybrid":
					map.setMapType(MapType.HYBRID_MAP_TYPE);
					break;
			}
		}
		
		private function setYear(year:int):void {
			var min:int = 1839;
			var max:int = new Date().fullYear;
			
			var delta:int = max - min;
			var yearDelta:int = year - min;
			//100:delta=x:yearDelta
			var oldStyle:int = 100 * yearDelta / delta;
			map.oldStyle = 100 - oldStyle; //inverse
			
			mediaBar.changeYear(year);
		}
		
		private function init(e:Event = null):void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
		
			
			this.map = new TimerouMap();			
			this.mediaBar = new MediaBar();
			this.mediaBar.map = map;

			addChild(map);
			addChild(mediaBar);

			map.addEventListener(TimerouMap.TIMEROUMAP_READY, mapReady);
			map.addEventListener(TimerouMap.TIMEROUMAP_MOVEEND, mapMoveEnd);		
		}
		
		private function mapMoveEnd(e:Event):void {
			ExternalInterface.call("MapCom.onMapMoveEnd");
		}
		
		private function mapReady(e:Event):void {
			setYear(new Date().getFullYear());
			
			if(!ExternalInterface.available) {
				searchLocation("Italia");
			} else {
				ExternalInterface.call("MapCom.onMapReady");
			}
		}
				
	}	
}
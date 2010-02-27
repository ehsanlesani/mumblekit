package
{
	import com.google.maps.LatLngBounds;
	import com.google.maps.MapType;
	
	import fl.transitions.Tween;
	
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import mumble.timerou.map.data.MediaData;
	import mumble.timerou.map.display.MediaIcon;
	import mumble.timerou.map.display.Preview;
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
		public static var LOAD_PICTURE_SERVICE_URL:String = BASEURL + "MediaLoader.aspx/LoadMedias";
		public static var MAPKEY:String = "ABQIAAAALR8bRKP-XQrzDCAShmrTvxQb16FdzuBr0nZgkL4aiWmiDXxN7xS6cnax6FiU5Req07YU9Mfy4LamTg";		
		
		private var map:TimerouMap = null;
		private var pictures:Array = new Array();
		private var tween:Tween = null;
		private var preview:Preview = null;
		private var debug:TextField = new TextField();
		
		public function Main():void 
		{
			ConfigureExternalInterface();
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function ConfigureExternalInterface():void {
			if(ExternalInterface.available) {
				ExternalInterface.addCallback("setBase", setBase);
				ExternalInterface.addCallback("setYear", setYear);		
				ExternalInterface.addCallback("changeType", changeType);
				ExternalInterface.addCallback("searchLocation", searchLocation);	
				ExternalInterface.addCallback("getMapBounds", getMapBounds);
				ExternalInterface.addCallback("showPreview", showPreview);
				ExternalInterface.addCallback("hidePreview", hidePreview);
				ExternalInterface.addCallback("showMediaLocations", showMediaLocations);
			}	
		}
		
		private function getMapBounds():* {
			if(map != null) {
				var bounds:LatLngBounds = map.latLngBounds;
				
				return { swlat: bounds.getSouthWest().lat(), swlng: bounds.getSouthWest().lng(), nelat: bounds.getNorthEast().lat(), nelng: bounds.getNorthEast().lng() };
			}
			
			return null;
		}
		
		private function setYear(year:int):void {
			var min:int = 1839;
			var max:int = new Date().fullYear;
			
			var delta:int = max - min;
			var yearDelta:int = year - min;
			//100:delta=x:yearDelta
			var oldStyle:int = 100 * yearDelta / delta;
			map.oldStyle = 100 - oldStyle; //inverse
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
		
		private function init(e:Event = null):void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			removeEventListener(Event.ADDED_TO_STAGE, init);		
			
			this.map = new TimerouMap();		
			addChild(map);
			
			this.preview = new Preview();
			addChild(preview);
			
			map.addEventListener(TimerouMap.TIMEROUMAP_READY, mapReady);
			map.addEventListener(TimerouMap.TIMEROUMAP_MOVEEND, mapMoveEnd);
			
			addChild(debug);			
			
		}
		
		private function showPreview(mediaDataSource:*):void {
			var mediaData:MediaData = new MediaData(mediaDataSource);
			showPreviewUsingMediaData(mediaData);
		}
		
		private function showPreviewUsingMediaData(mediaData:MediaData):void {
			var point:Point = map.getPicturePoint(mediaData);

			if(!preview.visible) { 
				preview.show(point);
			} else { 
				preview.move(point);
			}
			
			preview.loadPicture(mediaData);
		}
		
		private function hidePreview():void {
			preview.hide();
		}
		
		private function mapMoveEnd(e:Event):void {
			if(ExternalInterface.available) {
				ExternalInterface.call("MapCom.onMapMoveEnd");
			}
		}
		
		private function showMediaLocations(medias:Array):void {
			map.clearMediaLocations();
			
			for each(var mediasource:* in medias) {
				var media:MediaData = new MediaData(mediasource);
				if(media != null) {
					showMediaLocation(media);
				}
			}
		}
		
		private function showMediaLocation(media:MediaData):void {
			var icon:MediaIcon = map.showMediaLocation(media);
			icon.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
				showPreviewUsingMediaData(media);
			});
		}
		
		private function mapReady(e:Event):void {
			if(!ExternalInterface.available) {
				searchLocation("Italia");
			} else {
				ExternalInterface.call("MapCom.onMapReady");
			}
		}
				
	}	
}
package
{
	import com.google.maps.LatLngBounds;
	import com.google.maps.MapType;
	
	import fl.transitions.Tween;
	
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import mumble.timerou.map.controls.RoundedButton;
	import mumble.timerou.map.data.MediaData;
	import mumble.timerou.map.display.Border;
	import mumble.timerou.map.display.MediaIcon;
	import mumble.timerou.map.display.Preview;
	import mumble.timerou.map.display.TimerouMap;
	import mumble.timerou.map.events.TimebarEvent;
	import mumble.timerou.map.net.TimebarConnection;
	
	
	/**
	 * ...
	 * @author bruno
	 */
	
	[SWF(height = 600, width = 800, backgroundColor = 0xFFFFFF)]
	public class Main extends MovieClip 
	{
		public static var BASEURL:String = "http://localhost:1095/";
		public static var BASEPICTURESURL:String = BASEURL + "Pictures/";
		public static var LOAD_PICTURE_SERVICE_URL:String = BASEURL + "MediaLoader.aspx/LoadMedias";
		public static var MAPKEY:String = "ABQIAAAALR8bRKP-XQrzDCAShmrTvxQb16FdzuBr0nZgkL4aiWmiDXxN7xS6cnax6FiU5Req07YU9Mfy4LamTg";		
		
		private var map:TimerouMap = null;
		private var pictures:Array = new Array();
		private var tween:Tween = null;
		private var preview:Preview = null;
		private var debug:TextField = new TextField();
		private var currentMedias:Array;
		private var maskShape:Shape = new Shape();
		
		private var timebarConnection:TimebarConnection = new TimebarConnection();
		
		public function Main():void 
		{
			ConfigureExternalInterface();
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function ConfigureExternalInterface():void {
			if(ExternalInterface.available) {
				ExternalInterface.addCallback("changeType", changeType);
				ExternalInterface.addCallback("searchLocation", searchLocation);
				ExternalInterface.addCallback("setNavigationMode", setNavigationMode);
				ExternalInterface.addCallback("setLocationMode", setLocationMode);
			}	
		}
				
		private function setNavigationMode():void {
			map.navigationMode();
		}				
		
		private function setLocationMode():void {
			map.locationMode();
		}				
				
		private function init(e:Event = null):void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			removeEventListener(Event.ADDED_TO_STAGE, init);		
			
			this.map = new TimerouMap();		
			addChild(map);
			
			addChild(new Border());
						
			this.preview = new Preview();
			addChild(preview);

			drawMaskShape();
			addChild(maskShape);
			mask = maskShape;			
			
			stage.addEventListener(Event.RESIZE, drawMaskShape);
			
			map.addEventListener(TimerouMap.TIMEROUMAP_MOVESTART, mapMoveStart);
			map.addEventListener(TimerouMap.TIMEROUMAP_MOVEEND, mapMoveEnd);
			map.addEventListener(TimerouMap.NAVIGATION_MODE_SELECTED, navigationModeSelected);
			
			//debug.text = ExternalInterface.available.toString();
			//addChild(debug);		
			
			timebarConnection.addEventListener(TimebarEvent.YEAR_CHANGED, onYearChanged);
			timebarConnection.addEventListener(TimebarEvent.SHOW_MEDIA_LOCATIONS, onShowMediaLocations);
			timebarConnection.addEventListener(TimebarEvent.SHOW_PREVIEW, onShowPreview);
			timebarConnection.addEventListener(TimebarEvent.HIDE_PREVIEW, onHidePreview);
		}
		
		private function drawMaskShape(e:Event=null):void {
			var g:Graphics = maskShape.graphics;
			g.clear();
			g.beginFill(0xFFFFFF);
			g.drawRoundRect(0, 0, stage.stageWidth, stage.stageHeight, 15, 15);
			g.endFill();
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
		
		private function onYearChanged(e:TimebarEvent):void {
			setYear(e.year);
		}
		
		private function onShowPreview(e:TimebarEvent):void {
			var mediaData:MediaData = null;
			//try to find media data by id
			for each(var item:MediaData in currentMedias) {
				if(item.id == e.id) {
					mediaData = item;
					break;
				}					 
			}
			
			if(mediaData != null) {
				showPreviewUsingMediaData(mediaData);
			}
		}
		
		private function onHidePreview(e:TimebarEvent):void {
			hidePreview();
		}
		
		private function onShowMediaLocations(e:TimebarEvent):void {
			currentMedias = e.mediasData;
			
			map.clearMediaLocations();
			
			for each(var mediaData:MediaData in currentMedias) {
				showMediaLocation(mediaData);
			}
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
			
			preview.loadMedia(mediaData);
		}
		
		private function hidePreview():void {
			preview.hide();
		}
		
		private function mapMoveStart(e:Event):void {		
			hidePreview();
		}
		
		private function navigationModeSelected(e:Event):void {		
			if(ExternalInterface.available) {
				ExternalInterface.call("MapCom.navigationModeSelected");
			}
		}
		
		private function mapMoveEnd(e:Event):void {		
			timebarConnection.setBounds(map.latLngBounds);
		}
		
		private function showMediaLocation(media:MediaData):void {
			var icon:MediaIcon = map.showMediaLocation(media);
			icon.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
				showPreviewUsingMediaData(media);
			});
		}
				
	}	
}
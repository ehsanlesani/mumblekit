package mumble.timerou.map.display
{
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.Map;
	import com.google.maps.MapEvent;
	import com.google.maps.MapMoveEvent;
	import com.google.maps.MapType;
	import com.google.maps.controls.PositionControl;
	import com.google.maps.controls.ZoomControl;
	import com.google.maps.interfaces.IMapType;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	import com.google.maps.services.ClientGeocoder;
	import com.google.maps.services.GeocodingEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BitmapFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	
	import mumble.timerou.map.data.PictureData;
	/**
	 * ...
	 * @author bruno
	 */
	public class TimerouMap extends Sprite
	{		
		public static const TIMEROUMAP_READY:String = "timerouMapReady";
		public static const TIMEROUMAP_MOVESTART:String = "timerouMapMoveStart";
		public static const TIMEROUMAP_MOVEEND:String = "timerouMapMoveEnd";
		
		private const MARGIN_BOTTOM:int = 60;
		
		private var map:Map = null;
		private var filter:ColorMatrixFilter = new ColorMatrixFilter();
		private var pictureMarkers:Array = new Array();
		
		public var ready:Boolean = false;

		private var _oldStyle:int = 0;
		public function set oldStyle(value:int):void {
			_oldStyle = value;
			if (_oldStyle < 0) { _oldStyle = 0; }
			if (_oldStyle > 100) { _oldStyle = 100; }
			filter.matrix = calculateFilterMatrix();
			setMapFilter(filter);
		}		
		public function get oldStyle():int { return _oldStyle; }
		public function get latLngBounds():LatLngBounds { return map.getLatLngBounds() }
		
		private var normalMatrix:Array =[
				1, 0, 0, 0, 0, 
				0, 1, 0, 0, 0,
				0, 0, 1, 0, 0,
				0, 0, 0, 1, 0];

		private var sepiaMatrix:Array = [
			0.5144000053405762, 0.6151999950408935, 0.15119999647140503, 0, 0,
			0.279200005531311, 0.748799991607666, 0.1343999981880188, 0, 0,
			0.21760001182556152, 0.4271999835968018, 0.3047999978065491, 0, 0,
			0, 0, 0, 1, 0];
		
		private var rLum:Number = 0.2225;
		private var gLum:Number = 0.7169;
		private var bLum:Number = 0.0606;
			
		private var bwMatrix:Array = [
			rLum, gLum, bLum, 0, 0,
			rLum, gLum, bLum, 0, 0,
			rLum, gLum, bLum, 0, 0,
			0, 0, 0, 1, 0];
		
		public function TimerouMap() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			map = new Map();
			map.key = Main.MAPKEY;
			map.addEventListener(MapEvent.MAP_READY, onMapReady);
			map.addEventListener(MapMoveEvent.MOVE_START, onMapMoveStart);
			map.addEventListener(MapMoveEvent.MOVE_END, onMapMoveEnd);
			
			addChild(map);
		}
		
		private function onMapReady(e:MapEvent):void {		
			map.setSize(new Point(stage.stageWidth, stage.stageHeight - MARGIN_BOTTOM));
			map.setCenter(new LatLng(40.6686534, 16.6060872), 5);
			map.setMapType(MapType.NORMAL_MAP_TYPE);
			map.addControl(new ZoomControl()); 
  			map.addControl(new PositionControl());
			map.enableScrollWheelZoom();	
			
			ready = true;			
			dispatchEvent(new Event(TIMEROUMAP_READY));
			stage.addEventListener(Event.RESIZE, function(e:Event):void { 
				map.setSize(new Point(stage.stageWidth, stage.stageHeight - MARGIN_BOTTOM)); 
			});
		}		
		
		private function onMapMoveStart(e:MapEvent):void {
			dispatchEvent(new Event(TIMEROUMAP_MOVESTART));
		}
		
		private function onMapMoveEnd(e:MapEvent):void {
			dispatchEvent(new Event(TIMEROUMAP_MOVEEND));
		}
		
		private function calculateFilterMatrix():Array {
			var invertedOldStyle:int = 100 - _oldStyle; //inversion to be oldest at 100%
			var oldMatrix:Array = bwMatrix;
			var newMatrix:Array = normalMatrix;
			var percValue:int = invertedOldStyle - 50;
			
			if (invertedOldStyle <= 50) {
				newMatrix = bwMatrix;
				oldMatrix = sepiaMatrix;
				percValue = invertedOldStyle;
			}
			
			var result:Array = new Array();
			for (var i:int = 0; i < newMatrix.length; i++) {
				result[i] = ((percValue * (newMatrix[i] - oldMatrix[i]))  / 50.0) + oldMatrix[i];
     		}

			return result;
		}
		
		private function setMapFilter(filter:BitmapFilter):void {
			var s1:Sprite = map.getChildAt(1) as Sprite;
			var s2:Sprite = s1.getChildAt(0) as Sprite;
			s2.filters = [ filter ];
		}
		
		public function showPictureLocation(pictureData:PictureData):PictureIcon {
			var latLng:LatLng = pictureData.latLng;
			var icon:PictureIcon = new PictureIcon();			
			var options:MarkerOptions = new MarkerOptions();
			options.icon = icon;
			var marker:Marker = new Marker(latLng, options);
			pictureMarkers.push(marker);
			map.addOverlay(marker);
			
			return icon;
		}
		
		public function clearPictureLocations():void {
			for each(var marker:Marker in pictureMarkers) {
				map.removeOverlay(marker);
			}
			
			pictureMarkers = new Array();
		}
		
		public function getPicturePoint(pictureData:PictureData):Point {
			return map.fromLatLngToViewport(pictureData.latLng);
		}
		
		public function setMapType(type:IMapType):void {
			map.setMapType(type);
		}
		
		public function goToLocation(key:String):void {
			var geocoder:ClientGeocoder = new ClientGeocoder(); 
		    geocoder.addEventListener(GeocodingEvent.GEOCODING_SUCCESS, 
  				function(event:GeocodingEvent):void { 
		        var placemarks:Array = event.response.placemarks; 
		        if (placemarks.length > 0) { 
	        		var accuracy:int = placemarks[0].AddressDetails.Accuracy;
		        	var zoom:int = 18 * accuracy / 8;
		        	zoom += 3;
		        	
		        	map.setCenter(placemarks[0].point, zoom);
		        } 
		    }); 
		    geocoder.addEventListener(GeocodingEvent.GEOCODING_FAILURE, 
		        function(event:GeocodingEvent):void { 
		            trace("Geocoding failed"); 
		        }); 
		    geocoder.geocode(key); 
		}
		
	}

}
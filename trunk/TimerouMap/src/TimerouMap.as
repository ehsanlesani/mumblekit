package  
{
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.Map;
	import com.google.maps.MapEvent;
	import com.google.maps.MapMouseEvent;
	import com.google.maps.MapMoveEvent;
	import com.google.maps.MapType;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	/**
	 * ...
	 * @author bruno
	 */
	public class TimerouMap extends Sprite
	{		
		private var loadedPictures:Array = new Array();
		
		private var map:Map = new Map();
		private var mapKey:String = "ABQIAAAALR8bRKP-XQrzDCAShmrTvxRZcg6rHxTBMZ4Dun_V7KJl7bsRkRTyyWCSl2lWQpqYDZamuBcqyGfb-Q";		
		private var filter:ColorMatrixFilter = new ColorMatrixFilter();
		
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
			map.key = mapKey;
			map.addEventListener(MapEvent.MAP_READY, onMapReady);
			map.addEventListener(MapMoveEvent.MOVE_END, onMapMoveEnd);
			
			addChild(map);
		}
		
		private function onMapReady(e:MapEvent):void {
		
			map.setSize(new Point(stage.stageWidth, stage.stageHeight));
			map.setCenter(new LatLng(40.6686534, 16.6060872), 5)
			map.setMapType(MapType.NORMAL_MAP_TYPE);
			map.enableScrollWheelZoom();	
			
			createButtons();
			
			ready = true;			
			dispatchEvent(new Event("timerouMapReady"));
			stage.addEventListener(Event.RESIZE, function(e:Event):void { 
				map.setSize(new Point(stage.stageWidth, stage.stageHeight)); 
				hibridButton.x = stage.stageWidth - hibridButton.width - 5;
				roadButton.x = stage.stageWidth - roadButton.width * 2 - 10;
			});
		}		
		
		private function onMapMoveEnd(e:MapEvent):void {
			dispatchEvent(new Event("timerouMapMove"));
		}
		
		private var hibridButton:RoundedButton = new RoundedButton();
		private var roadButton:RoundedButton = new RoundedButton();
		
		private function createButtons():void {
			hibridButton = new RoundedButton();
			hibridButton.y = 5;
			hibridButton.text = "Hibrid";
			hibridButton.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void { map.setMapType(MapType.HYBRID_MAP_TYPE); } );
			addChild(hibridButton);

			roadButton.y = 5;
			roadButton.text = "Road";
			roadButton.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void { map.setMapType(MapType.NORMAL_MAP_TYPE); } );
			addChild(roadButton);			

			hibridButton.x = stage.stageWidth - hibridButton.width - 5;
			roadButton.x = stage.stageWidth - roadButton.width * 2 - 10;
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
			/*var s1:Sprite = map.getChildAt(1) as Sprite;
			var s2:Sprite = s1.getChildAt(0) as Sprite;
			s2.filters = [ filter ];*/
			map.filters = [ filter ];
		}
		
		public function addPictures(pictures:*):void {
			//delete pictures not displaied in this array and add new pictures
			
			try 
			{
				var toDelete:Array = new Array();
				var toAdd:Array = new Array();
				
				//delete all loaded pictures that are not contained in new pictures array
				for (var x:int = 0; x < loadedPictures.length; x++)
				{
					var loadedPicture:* = loadedPictures[x];
					
					if (!pictureExists(pictures, loadedPicture)) {
						toDelete.push(loadedPicture);
					}
				}
				
				//add all pictures that are not contained in loadedPictures array
				for (var i:int = 0; i < pictures.length; i++)
				{
					var newPicture:* = pictures[i];
					
					if (!pictureExists(loadedPictures, newPicture)) {
						toAdd.push(newPicture);
					}
				}
				
				for (var y:int = 0; y < toDelete.length; y++)
				{
					deletePicture(toDelete[y]);
				}
				
				for (var z:int = 0; z < toAdd.length; z++)
				{
					addPicture(toAdd[z]);
				}
			}
			catch (err:Error)
			{
				trace(err);
			}				
		}
		
		public function pictureExists(pictures:Array, picture:*):Boolean {
			for (var i:int = 0; i < pictures.length; i++) {
				if (pictures[i].id == picture.id) {
					return true;
				}
			}
			return false;
		}
		
		public function addPicture(picture:*):void {
			var latLng:LatLng = new LatLng(picture.lat, picture.lng);
			var icon:PictureIcon = new PictureIcon("http://photos-d.ak.fbcdn.net/photos-ak-snc1/v347/177/89/1348804026/s1348804026_914076_4293.jpg");			
			var options:MarkerOptions = new MarkerOptions();
			options.icon = icon;
			var marker:Marker = new Marker(latLng, options);
			map.addOverlay(marker);
			
			this.loadedPictures.push(picture);
			picture.marker = marker;
		}
		
		public function deletePicture(picture:*):void {
			for (var i:int = 0; i < loadedPictures.length; i++) {
				if (loadedPictures[i].id == picture.id) {
					map.removeOverlay(loadedPictures[i].marker);
					loadedPictures.splice(i, 1);
					return;
				}
			}
		}		
	}

}
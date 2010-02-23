package mumble.timerou.map.data
{
	import com.google.maps.LatLngBounds;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	public class PictureDataLoader extends EventDispatcher {
		
		public var pictures:Array = null;
		public var totalCount:int  = 0;
		
		public var pageSize:int = 20;
		public var page:int = 1;
		public var hasMorePagesAfter:Boolean = false;
		public var hasMorePagesBefore:Boolean = false;
				
		private var bounds:LatLngBounds = null;
		private var year:int = 0;
		
		public function PictureDataLoader() { }
		
		private function setPicturesData(jsonData:String):void {
			this.pictures = new Array();
			var result:* = JSON.deserialize(jsonData);
			this.totalCount = result.totalCount;
			
			this.hasMorePagesBefore = this.page > 1;
			var lastResultIndex:int = this.page * this.pageSize;
			this.hasMorePagesAfter = this.totalCount > lastResultIndex;
			
			if (result != null && !result.error) {
				//load as known objects
				for(var i:int = 0; i < result.medias.length; i++) {
					this.pictures.push(new PictureData(result.medias[i]));
				}
			}
		}		
		
		public function load(bounds:LatLngBounds, year:int):void {
			this.hasMorePagesAfter = false;
			this.hasMorePagesBefore = false;
			
			this.bounds = bounds;
			this.year = year;			
			
			try 
			{
				var request:URLRequest = new URLRequest(Main.LOAD_PICTURE_SERVICE_URL);
				request.method = URLRequestMethod.POST;
				var variables:URLVariables = new URLVariables();			
				variables.swlat = bounds.getSouthWest().lat();
				variables.swlng = bounds.getSouthWest().lng(); 
				variables.nelat = bounds.getNorthEast().lat();
				variables.nelng = bounds.getNorthEast().lng();
				variables.year = this.year;
				if(this.page != 0) {
					variables.page = this.page;
					variables.pageSize = this.pageSize;
				}
				request.data = variables;
				var loader:URLLoader = new URLLoader();
				loader.addEventListener(Event.COMPLETE, function(e:Event):void { 
					setPicturesData(e.target.data);
					dispatchEvent(new Event(Event.COMPLETE));
				});
				loader.load(request);
			}
			catch (err:Error)
			{
				trace(err);
			}
		}
		
		public function loadNext():void {
			if(hasMorePagesAfter) {
				page++;
				load(this.bounds, this.year);
			}
		}
		
		public function loadPrevious():void {
			if(hasMorePagesBefore) {
				page--;
				load(this.bounds, this.year);
			}
		}
		
		
	}
}
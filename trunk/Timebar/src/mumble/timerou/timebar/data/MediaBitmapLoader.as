package mumble.timerou.timebar.data
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.system.Security;

	
	public class MediaBitmapLoader extends EventDispatcher
	{
		public var bitmap:Bitmap = null;

		private var mediaData:MediaData = null;
		
		public function MediaBitmapLoader(mediaData:MediaData) {
			this.mediaData = mediaData;
		}
		
		public function load():void {
			Security.allowDomain("img.youtube.com");
			//load picture
			var url:String = getUrl();
			
			var request:URLRequest = new URLRequest(url);
			var loader:Loader = new Loader();
			var loaderContext:LoaderContext = new LoaderContext(true);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void {	
				bitmap = loader.content as Bitmap;
				loader.unload();

				dispatchEvent(new Event(Event.COMPLETE));
			});

			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent):void {
				//draw error
				trace(e.text);
			});

			loader.load(request, loaderContext);
		}
		
		private function getUrl():String {
			if(mediaData == null) {
				return null;
			}
			
			if(mediaData.type == MediaData.MEDIATYPE_VIDEO) {
				return "http://img.youtube.com/vi/" + mediaData.videoData.youtubeId + "/2.jpg"
			} else if(mediaData.type == MediaData.MEDIATYPE_PICTURE) {
				return TimebarMain.BASEPICTURESURL + mediaData.pictureData.avatarPath;
			} else {
				return null;
			}
		}
	}
}
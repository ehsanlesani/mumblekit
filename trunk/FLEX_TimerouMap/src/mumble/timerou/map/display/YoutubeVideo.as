package mumble.timerou.map.display
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.Security;
	
	public class YoutubeVideo extends MovieClip {
		
		public var videoHeight:Number = 100;
		public var videoWidth:Number = 100;

		private var player:* = null;
		private var id:String = null;
		private var loading:Loading = null;
		
		public function YoutubeVideo() {
			Security.allowDomain("www.youtube.com");
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			
			graphics.beginFill(0x000000);
			graphics.drawRect(0, 0, videoWidth, videoHeight);
			graphics.endFill();
			
			if(player == null) {
				loading = new Loading();
				loading.x = videoWidth / 2;
				loading.y = videoHeight / 2;
				addChild(loading);
				var request:URLRequest = new URLRequest("http://www.youtube.com/apiplayer?version=3");
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(le:Event):void {
					player = loader.content;
					addChild(player);
					removeChild(loading);
					player.addEventListener("onReady", function(pe:Event):void {
						player.setSize(videoWidth, videoHeight);
						dispatchEvent(new Event(Event.COMPLETE));
					});
				});
				loader.load(request);
			} else {
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		public function loadAndPlay(id:String):void {
			if(player == null) {
				return;
			}
			
			this.id = id;
			player.loadVideoById(id);
		}
		
		public function destroy():void {
			if(player == null) {
				return;
			}
			
			player.destroy();
		}
	}
}
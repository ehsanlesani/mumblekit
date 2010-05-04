package mumble.timerou.timebar.events
{
	import flash.events.Event;
	
	import mumble.timerou.timebar.data.MediaData;
	
	public class MediaEvent extends Event
	{
		public static const CLICK:String = "mediaClick";
		
		public var mediaData:MediaData = null;
		
		public function MediaEvent(type:String, mediaData:MediaData) {
			super(type);
			this.mediaData = mediaData;
		}

	}
}
package mumble.timerou.map.data
{
	import flash.events.Event;
	
	public class PictureEvent extends Event
	{
		public var pictureData:MediaData = null;
		
		public function PictureEvent(type:String, pictureData:MediaData)
		{
			super(type);
			this.pictureData = pictureData;
		}

	}
}
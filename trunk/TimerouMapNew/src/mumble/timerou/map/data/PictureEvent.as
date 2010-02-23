package mumble.timerou.map.data
{
	import flash.events.Event;
	
	public class PictureEvent extends Event
	{
		public var pictureData:PictureData = null;
		
		public function PictureEvent(type:String, pictureData:PictureData)
		{
			super(type);
			this.pictureData = pictureData;
		}

	}
}
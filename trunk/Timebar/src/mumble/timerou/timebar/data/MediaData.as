package mumble.timerou.timebar.data
{
	import com.google.maps.LatLng;
	
	public class MediaData
	{
		public static const MEDIATYPE_PICTURE:String = "Picture";
		public static const MEDIATYPE_VIDEO:String = "Video";
		
		public var pictureData:PictureData = null;
		public var videoData:VideoData = null;
		
		public var title:String = null;
		public var id:String = null;
		public var latLng:LatLng = null;
		public var country:String = null;
		public var region:String = null;
		public var city:String = null;
		public var address:String = null;
		public var year:int = 2000;
		public var type:String = null;
		//public var avatar:Bitmap = null;
		//public var original:Bitmap = null;
		
		//Creates a new instance of PictureData using startingData service data		 
		public function MediaData(startingData:* = null)
		{
			if(startingData == null) { return; }
			
			this.title = startingData.title;
			this.id = startingData.id;
			this.latLng = new LatLng(startingData.lat, startingData.lng);	
			this.country = startingData.country;
			this.region = startingData.region;
			this.city = startingData.city;
			this.address = startingData.address;
			this.year = startingData.year
			this.type = startingData.type;
			
			if(this.type == MEDIATYPE_PICTURE) {
				pictureData = new PictureData();
				pictureData.avatarPath = startingData.pictureData.avatarPath;
				pictureData.optimizedPath = startingData.pictureData.optimizedPath;	
				pictureData.originalPath = startingData.pictureData.originalPath;
			} else if(this.type == MEDIATYPE_VIDEO) {
				videoData = new VideoData();
				videoData.youtubeId = startingData.videoData.youtubeId;
			}
			
		}
	}
}
package mumble.timerou.map.data
{
	import com.google.maps.LatLng;
	
	public class PictureData
	{
		public var avatarPath:String = null;
		public var optimizedPath:String = null;
		public var originalPath:String = null;
		public var title:String = null;
		public var id:String = null;
		public var latLng:LatLng = null;
		public var country:String = null;
		public var region:String = null;
		public var city:String = null;
		public var address:String = null;
		public var year:int = 2000;
		//public var avatar:Bitmap = null;
		//public var original:Bitmap = null;
		
		//Creates a new instance of PictureData using startingData service data		 
		public function PictureData(startingData:*)
		{
			this.avatarPath = startingData.pictureData.avatarPath;
			this.optimizedPath = startingData.pictureData.optimizedPath;
			this.title = startingData.title;
			this.id = startingData.id;
			this.latLng = new LatLng(startingData.lat, startingData.lng);	
			this.country = startingData.country;
			this.region = startingData.region;
			this.city = startingData.city;
			this.address = startingData.address;
			this.year = startingData.year
		}
	}
}
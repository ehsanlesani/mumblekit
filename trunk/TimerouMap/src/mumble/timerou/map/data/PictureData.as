package mumble.timerou.map.data
{
	import com.google.maps.LatLng;
	
	public class PictureData
	{
		public var avatarPath:String = null;
		public var title:String = null;
		public var id:String = null;
		public var latLng:LatLng = null;
		
		//Creates a new instance of PictureData using startingData service data		 
		public function PictureData(startingData:*)
		{
			this.avatarPath = startingData.avatarPath;
			this.title = startingData.title;
			this.id = startingData.id;
			this.latLng = new LatLng(startingData.lat, startingData.lng);	
		}
	}
}
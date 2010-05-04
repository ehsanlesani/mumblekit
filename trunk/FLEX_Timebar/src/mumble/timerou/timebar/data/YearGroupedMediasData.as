package mumble.timerou.timebar.data
{
	public class YearGroupedMediasData
	{
		public var year:int;
		public var x:Number;
		public var medias:Array = new Array();
		
		public function YearGroupedMediasData(source:*) {
			year = source.year;
			for each(var mediaSource:* in source.medias) {
				medias.push(new MediaData(mediaSource));
			}
		}

	}
}
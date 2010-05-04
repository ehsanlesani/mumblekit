package mumble.timerou.timebar.data
{
	public class YearGroupedMediasResponse
	{
		public var groupedMedias:Array = new Array();
        public var hasMediasBefore:Boolean;
        public var hasMediasAfter:Boolean;
        public var minYearDistance:int;
        public var minYear:int;
        public var maxYear:int;
		
		public function YearGroupedMediasResponse(sourceData:*) {
			hasMediasBefore = sourceData.hasMediasBefore;
			hasMediasAfter = sourceData.hasMediasAfter;
			minYearDistance = sourceData.minYearDistance;
			minYear = sourceData.minYear;
			maxYear = sourceData.maxYear;
			
			for each(var groupedMedia:* in sourceData.groupedMedias) {
				groupedMedias.push(new YearGroupedMediasData(groupedMedia));
			}
		}

	}
}
package mumble.timerou.map.utils
{
	public class StringUtils
	{
		public function StringUtils()
		{
		}
		
		public static function isNullOrEmpty(value:String):Boolean 
		{
			if(value==null)
				return true;
			
			if(value.length==0)
				return true;
			
			return false;
		}
	}
}
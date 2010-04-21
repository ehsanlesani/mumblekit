package mumble.timerou.map.utils
{
	public class ExtString
	{
		public function ExtString()
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
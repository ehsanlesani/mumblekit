package mumble.timerou.map.display
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import mumble.timerou.map.utils.ExtString;

	public class Letter extends TextField
	{
		private var _char:String = "";
		
		public function Letter(text:String = "")
		{
			_char = text;
			
			addEventListener(Event.ADDED_TO_STAGE, init);			
		}
		
		private function init(e:Event):void 
		{
			if(ExtString.isNullOrEmpty(_char))
				return;
			
			draw();
		}
		
		private function draw():void
		{			
			this.text = _char;		
			var format:TextFormat = new TextFormat();
			format.font = "Lucida Sans Unicode";
			format.size = 28;
			this.setTextFormat(format);
		}
		
		public function set Char(value:String):void 
		{
			_char = value;
		}
		
		public function get Char():String 
		{
			return _char;
		}
	}
}
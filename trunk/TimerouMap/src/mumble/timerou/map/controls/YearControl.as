package mumble.timerou.map.controls
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import mumble.timerou.map.display.Letter;
	import mumble.timerou.map.display.RoundContainer;
	import mumble.timerou.map.visualSpace.Margin;

	public class YearControl extends MovieClip
	{
		private var _width:int = 152;
		private var _height:int = 30;
		private var _radius:int = 8;
		private var _alpha:Number = 0.9;
		private var _margin:Margin = new Margin(5, 6);
		private var year:int = new Date().getFullYear();
		private var letters:Array = new Array();
				
		public function YearControl()		
		{			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{	
			adjustPosition(e);			
			addChild(new RoundContainer(_width, _height, _radius, _alpha));
			drawYear();
						
			stage.addEventListener(Event.RESIZE, adjustPosition);			
		}
		
		private function adjustPosition(e:Event):void 
		{
			this.x = stage.stageWidth - _width - _margin.right;
			this.y = _margin.top;
		}
		
		private function drawYear():void 
		{
			for (var i:int = 0; i < 4; i++) 
			{
				var letter:Letter = new Letter("0");
				letters.push(letter);
				addChild(letter);		
				letter.x = i * letter.width;	
				letter.y = -4;	
			}					
		}
		
		public function setYear(year:int):void 
		{
			var syear:String = year.toString();			
			for(var i:int = 0; i < 4; i++) 
			{
				var num:String = syear.charAt(i);
				var letter:Letter = letters[i];
				letter.char = num;
			}
		}
	}
}
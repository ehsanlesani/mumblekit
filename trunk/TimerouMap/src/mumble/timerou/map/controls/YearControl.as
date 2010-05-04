package mumble.timerou.map.controls
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	
	import mumble.timerou.map.controls.wrappers.RoundContainer;
	import mumble.timerou.map.data.Styles;
	import mumble.timerou.map.visualSpace.Margin;
	import mumble.timerou.map.writing.AnimatedLetter;

	public class YearControl extends MovieClip
	{
		private var _width:int = 152;
		private var _height:int = 30;
		private var _radius:int = 8;
		private var _alpha:Number = 0.9;
		private var _margin:Margin = new Margin(5, 6);
		private var _year:int = new Date().getFullYear();
		private var _letters:Array = new Array();
		private var _currentActionDescription:String = "exploring";
		private var _startPosition:Margin = new Margin(0,0,0,75);
		private var _letterSpacing:int = -5;
				
		public function YearControl()		
		{			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{	
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			adjustPosition(e);			
			addChild(new RoundContainer(_width, _height, _radius, _alpha));
			addStaticText();
			drawYear();
						
			stage.addEventListener(Event.RESIZE, adjustPosition);			
		}
		
		private function adjustPosition(e:Event):void 
		{
			this.x = stage.stageWidth - _width - _margin.right;
			this.y = _margin.top;
		}
		
		private function addStaticText():void 
		{
			var actionDesc:TextField = new TextField();
			actionDesc.text = _currentActionDescription;
			actionDesc.antiAliasType = AntiAliasType.ADVANCED;
			actionDesc.selectable = false;
			actionDesc.setTextFormat(Styles.getActionDescriptionTextFormat());
			actionDesc.x = 5;
			addChild(actionDesc);
		}
		
		private function drawYear():void 
		{
			for (var i:int = 0; i < 4; i++) 
			{
				var letter:AnimatedLetter = new AnimatedLetter("0");
				_letters.push(letter);
				addChild(letter);		
				letter.x = _startPosition.left + i * (letter.width + _letterSpacing);	
				letter.y = -4;
			}					
			
			setYear(_year);
		}
		
		public function setYear(year:int):void 
		{
			var syear:String = year.toString();			
			for(var i:int = 0; i < 4; i++) 
			{
				var num:String = syear.charAt(i);
				var letter:AnimatedLetter = _letters[i];
				letter.char = num;
			}
		}
	}
}
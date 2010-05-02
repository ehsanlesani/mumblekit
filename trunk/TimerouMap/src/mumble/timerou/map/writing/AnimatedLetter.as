package mumble.timerou.map.writing
{
	import fl.transitions.Tween;
	import fl.transitions.easing.Strong;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	
	import mumble.timerou.map.data.Styles;

	public class AnimatedLetter extends Sprite
	{
		private var _letter:TextField = new TextField();
		private var _char:String;
		private var _tween:Tween = null;
		
		public function AnimatedLetter(character:String)
		{
			_char = character;
			
			addEventListener(Event.ADDED_TO_STAGE, init);			
		}
		
		private function init(e:Event):void 
		{	
			removeEventListener(Event.ADDED_TO_STAGE, init);
		
			drawMask();
			adjustLetterSettings();
			doAnimation();
		}
		
		private function drawMask():void 
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0xFF0000);
			shape.graphics.drawRect(0, 8, 20, 22);
			
			this.mask = shape;
			addChild(shape);
		}
				
		private function adjustLetterSettings():void 
		{			
			_letter.autoSize = TextFieldAutoSize.LEFT;
			_letter.antiAliasType = AntiAliasType.ADVANCED;
			_letter.selectable = false;
			_letter.text = _char;
			
			// TODO: ma come cazzo è possibile?!
			_letter.defaultTextFormat = Styles.getAnimatedLetterTextFormat();
			_letter.setTextFormat(Styles.getAnimatedLetterTextFormat());
			
			addChild(_letter);
		}	
		
		public function doAnimation():void 
		{
			_tween = new Tween(_letter, "y", Strong.easeOut, -30, 0, 0.8, true);	
		}	
		
		public function set char(value:String):void 
		{
			if(_char != value) 
			{
				_char = value;		
				_letter.text = value;	
				doAnimation();
			}
		}
		
		public function get char():String 
		{
			return _char;
		}
	}
}
package mumble.timerou.map.display
{
	import fl.transitions.Tween;
	import fl.transitions.easing.Strong;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;

	public class Letter extends Sprite
	{
		private var _letter:TextField;
		private var _char:String;
		private var _textFormat:TextFormat;
		private var _tween:Tween = null;
		
		public function Letter(character:String)
		{
			_char = character;
			
			addEventListener(Event.ADDED_TO_STAGE, init);			
		}
		
		private function init(e:Event):void 
		{	
			removeEventListener(Event.ADDED_TO_STAGE, init);
		
			drawMask();
			formatField();
			createLetter();
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
		
		private function formatField():void
		{
			_textFormat = new TextFormat();
			_textFormat.font = "Lucida Sans Unicode";
			_textFormat.size = 28;
		}
		
		private function createLetter():void 
		{
			_letter = new TextField();
			_letter.defaultTextFormat = _textFormat;
			_letter.autoSize = TextFieldAutoSize.LEFT;
			_letter.selectable = false;
			_letter.text = _char;
			
			addChild(_letter);
		}	
		
		public function doAnimation():void 
		{
			_tween = new Tween(_letter, "y", Strong.easeOut, -30, 0, 0.5, true);	
			//_tween = new Tween(_letter, "y", Strong.easeOut, 28, 0, 0.25, true);
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
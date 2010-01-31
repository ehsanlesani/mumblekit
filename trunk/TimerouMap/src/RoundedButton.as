package  
{
	import com.google.maps.wrappers.SpriteFactory;
	import fl.transitions.easing.Regular;
	import fl.transitions.TransitionManager;
	import fl.transitions.Tween;
	import flash.display.Graphics;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author bruno
	 */
	public class RoundedButton extends Sprite
	{
		private var buttonHeight:int = 22;		
		private var buttonWidth:int = 80;

		private var textField:TextField = new TextField();
		private var over:Sprite = new Sprite();
		private var normal:Sprite = new Sprite();
		private var tween:Tween =  null;
		
		public function set text(value:String):void { textField.text = value; }		
		public function get text():String { return textField.text; }
		
		public function RoundedButton() 
		{
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			format.font = "verdana";
			format.size = 10;
			format.color = 0xDDDDDD;
			textField.defaultTextFormat = format;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			draw();	
			addText();
			
			addEventListener(MouseEvent.ROLL_OVER, mouseRollOver);
			addEventListener(MouseEvent.ROLL_OUT, mouseRollOut);
		}
		
		private function mouseRollOver(e:MouseEvent):void {
			buttonMode = true;
			if (tween != null && tween.isPlaying) tween.stop();
			tween = new Tween(this, "alpha", Regular.easeIn, this.alpha, 1, 0.2, true);
		}
		
		private function mouseRollOut(e:MouseEvent):void {
			buttonMode = false;
			if (tween != null && tween.isPlaying) tween.stop();
			tween = new Tween(this, "alpha", Regular.easeIn, this.alpha, 0.5, 0.2, true);
		}
		
		private function draw():void {
			var g:Graphics = this.graphics;
			g.beginFill(0x333333);
			g.drawRoundRect(0, 0, buttonWidth, buttonHeight, 5);			
			this.alpha = 0.5;
			filters = [ new DropShadowFilter() ];
		}
		
		private function addText():void {
			textField.y = 3;
			textField.width = buttonWidth;
			textField.height = 16;
			textField.mouseEnabled = false;
			addChild(textField);
		}
		
	}

}
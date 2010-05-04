package mumble.timerou.timebar.display
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import mumble.timerou.timebar.data.Styles;

	public class LinkButton extends Sprite
	{		
		private var textField:TextField = new TextField();
		private var textFormat:TextFormat = Styles.linkTextFormat;
		private var textOverFormat:TextFormat = Styles.linkTextOverFormat;
		
		public function set text(value:String):void {
			textField.text = value;
		}
		
		public function get text():String {
			return textField.text;
		}
		
		public function LinkButton() {
			textField.defaultTextFormat = textFormat;
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.text = "link";
			textField.selectable = false;
			
			addChild(textField);
			
			addEventListener(MouseEvent.ROLL_OVER, rollOver);
			addEventListener(MouseEvent.ROLL_OUT, rollOut);
			
			this.buttonMode = true;
			this.mouseChildren = false;
		}
		
		private function rollOver(e:MouseEvent):void {
			textField.setTextFormat(textOverFormat);
		}
		
		private function rollOut(e:MouseEvent):void {
			textField.setTextFormat(textFormat);
		}
		
	}
}
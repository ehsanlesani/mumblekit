package mumble.timerou.timebar.display
{
	import fl.transitions.Tween;
	import fl.transitions.easing.Regular;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	
	import mumble.timerou.timebar.data.Styles;
	import mumble.timerou.timebar.net.MapConnection;

	public class MediaPreviewButton extends Sprite
	{
		private var bitmap:Bitmap;
		private var mediaWidth:Number;
		private var mediaHeight:Number;
		private var overRectangle:Sprite;
		private var fadeTween:Tween;
		private var mapConnection:MapConnection;
		private var isVideo:Boolean;
		
		public function MediaPreviewButton(bitmap:Bitmap, mediaWidth:Number, mediaHeight:Number, isVideo:Boolean) {
			this.isVideo = isVideo;
			this.bitmap = bitmap;
			this.mediaWidth = mediaWidth;
			this.mediaHeight = mediaHeight;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(MouseEvent.ROLL_OVER, mouseRollOver);
			addEventListener(MouseEvent.ROLL_OUT, mouseRollOut);
		}
		
		private function init(e:Event):void {
			drawOverRectangle();
			drawPicture();
		}
		
		private function drawPicture():void {
			//scale picture
			var divY:Number = Styles.mediaPreviewSize.y / bitmap.height;
			var divX:Number = Styles.mediaPreviewSize.x / bitmap.width;		
			var minDiv:Number = Math.max(divX, divY);			
			var matrix:Matrix = new Matrix();

			matrix.scale(minDiv, minDiv);
			var newWidth:Number = bitmap.width * minDiv;
			var newHeight:Number = bitmap.height * minDiv;	
			var diffX:Number = Styles.mediaPreviewSize.x - newWidth;
			var diffY:Number = Styles.mediaPreviewSize.y - newHeight;
			matrix.translate(diffX / 2, diffY / 2);			
			
			graphics.beginBitmapFill(bitmap.bitmapData, matrix);
			graphics.lineStyle();
			
			/*graphics.drawRoundRect(0, 0, 
				mediaWidth, 
				mediaHeight, 
				Styles.mediaBoxCornerSize * 0.8, Styles.mediaBoxCornerSize * 0.8);*/
			graphics.drawRect(0, 0, 
				mediaWidth, 
				mediaHeight) 
			graphics.endFill();
			
			if(isVideo) {
				var playSize:Number = 20;
				graphics.beginFill(0x000000, 0.5);
				graphics.lineStyle(2, 0xFFFFFF, 0.6);
				graphics.moveTo(mediaWidth / 2 - playSize / 2, mediaHeight / 2 - playSize / 2);
				graphics.lineTo(mediaWidth / 2 + playSize / 2, mediaHeight / 2);
				graphics.lineTo(mediaWidth / 2 - playSize / 2, mediaHeight / 2 + playSize / 2);
				graphics.lineTo(mediaWidth / 2 - playSize / 2, mediaHeight / 2 - playSize / 2);
			}
		}
		
		private function drawOverRectangle():void {
			overRectangle = new Sprite();
			overRectangle.alpha = 0;
			
			overRectangle.graphics.lineStyle(Styles.mediaPreviewOverThickness, Styles.mediaPreviewOverRectColor);
			overRectangle.graphics.drawRect(
				0 + Styles.mediaPreviewOverThickness / 2,
				0 + Styles.mediaPreviewOverThickness / 2, 
				mediaWidth - Styles.mediaPreviewOverThickness, 
				mediaHeight - Styles.mediaPreviewOverThickness);

			addChild(overRectangle);			
		}
		
		private function mouseRollOver(e:MouseEvent):void {
			stopTween();
			fadeTween = new Tween(overRectangle, "alpha", Regular.easeOut, overRectangle.alpha, 1, 0.25, true);
		}
		
		private function mouseRollOut(e:MouseEvent):void {
			stopTween();
			fadeTween = new Tween(overRectangle, "alpha", Regular.easeOut, overRectangle.alpha, 0, 0.25, true);
		}
		
		private function stopTween():void {
			if(fadeTween != null && fadeTween.isPlaying) { fadeTween.stop(); }
		}
		
	}
}
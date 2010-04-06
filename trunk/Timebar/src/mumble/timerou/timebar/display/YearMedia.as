package mumble.timerou.timebar.display
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Matrix;
	
	import mumble.timerou.timebar.data.MediaBitmapLoader;
	import mumble.timerou.timebar.data.MediaData;
	import mumble.timerou.timebar.data.Styles;

	public class YearMedia extends MovieClip
	{
		public var mediaData:MediaData = null;
		private var loading:Loading = null;
		
		public function YearMedia(mediaData:MediaData) {
			this.mediaData = mediaData;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {	
			drawBorder();
			drawPointer();
			
			loading = new Loading();
			loading.x = Styles.yearMediaSize.x / 2;
			loading.y = Styles.yearMediaSize.y / 2;
			addChild(loading);
			
			var loader:MediaBitmapLoader = new MediaBitmapLoader(mediaData);
			loader.addEventListener(Event.COMPLETE, function(e:Event):void {
				if(loading != null) { removeChild(loading); } //remove loading
				if(loader.bitmap != null) {
					var bitmap:Bitmap = loader.bitmap;
					//scale picture
					var divY:Number = Styles.yearMediaSize.y / bitmap.height;
					var divX:Number = Styles.yearMediaSize.x / bitmap.width;		
					var minDiv:Number = Math.max(divX, divY);			
					var matrix:Matrix = new Matrix();

					matrix.scale(minDiv, minDiv);
					var newWidth:Number = bitmap.width * minDiv;
					var newHeight:Number = bitmap.height * minDiv;	
					var diffX:Number = Styles.yearMediaSize.x - newWidth;
					var diffY:Number = Styles.yearMediaSize.y - newHeight;
					matrix.translate(diffX / 2, diffY / 2);			
					
					graphics.beginBitmapFill(bitmap.bitmapData, matrix);
					graphics.lineStyle();
					graphics.drawRoundRect(
						Styles.yearMediaLineThickness, 
						Styles.yearMediaLineThickness, 
						Styles.yearMediaSize.x - Styles.yearMediaLineThickness * 2, 
						Styles.yearMediaSize.y - Styles.yearMediaLineThickness * 2, 
						Styles.cornerSize * 0.8, Styles.cornerSize * 0.8);
					graphics.endFill();
				}
			});
			loader.load();
		}
		
		private function drawBorder():void {
			graphics.lineStyle();
			graphics.beginFill(Styles.yearMediaLineColor);
			graphics.drawRoundRect(0, 0, Styles.yearMediaSize.x, Styles.yearMediaSize.y, Styles.cornerSize, Styles.cornerSize);
			graphics.endFill();
		}
		
		private function drawPointer():void {
			var randomNumber:Number = Math.random() * 2.999999;
			var rnd:int = Math.floor(randomNumber);
			var x:Number = Styles.yearMediaSize.x / 2 - Styles.yearMediaPointerSize.x / 2;
			var y:Number = Styles.yearMediaSize.y; 
			
			graphics.beginFill(Styles.yearMediaLineColor);
			
			if(rnd == 0) { //pointer on center
				x = this.width / 2 - Styles.yearMediaPointerSize.x / 2;
				y = this.height; 
				graphics.moveTo(x, y);
				graphics.lineTo(x + Styles.yearMediaPointerSize.x, y);
				graphics.lineTo(x + Styles.yearMediaPointerSize.x / 2, y + Styles.yearMediaPointerSize.y);
				graphics.lineTo(x, y);
			} else if(rnd == 1) { //pointer on left
				x = this.width / 7 * 2 - Styles.yearMediaPointerSize.x / 2;
				y = this.height; 
				graphics.moveTo(x, y);
				graphics.lineTo(x + Styles.yearMediaPointerSize.x, y);
				graphics.lineTo(x + Styles.yearMediaPointerSize.x / 4 * 1, y + Styles.yearMediaPointerSize.y);
				graphics.lineTo(x, y);
			} else if(rnd == 2) { //pointer on right
				x = this.width / 7 * 5 - Styles.yearMediaPointerSize.x / 2;
				y = this.height; 
				graphics.moveTo(x, y);
				graphics.lineTo(x + Styles.yearMediaPointerSize.x, y);
				graphics.lineTo(x + Styles.yearMediaPointerSize.x / 4 * 3, y + Styles.yearMediaPointerSize.y);
				graphics.lineTo(x, y);
			}
			
			graphics.endFill();
			 
		}
	}
}
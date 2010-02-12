package mumble.timerou.map.data
{
	import flash.display.Bitmap;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import flash.utils.setTimeout;
	
	import mumble.timerou.map.display.Loading;

	public class RemotePicture extends Sprite
	{
		public static const LOAD_COMPLETE:String = "loadComplete";
		
		public var url:String = null;
		public var pictureWidth:int = 0;
		public var pictureHeight:int = 0;
		public var maintainProportions:Boolean = true;
		public var borderColor:uint = 0x555555;
		public var borderOverColor:uint = 0xEEEEEE;	
		public var showBorder:Boolean = true;
		public var roundCornerSize:int = 0;
		
		public function RemotePicture(url:String, width:int, height:int, maintainProportions:Boolean = true) {
			this.url = url;
			this.pictureWidth = width;
			this.pictureHeight = height;
			this.maintainProportions = maintainProportions;
						
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		
		private function init(e:Event):void {
			//drawBackground
			var g:Graphics = graphics;
			if(showBorder) { g.lineStyle(1, borderColor); }
			if(roundCornerSize > 0) { g.drawRoundRect(0, 0, pictureWidth, pictureHeight, roundCornerSize, roundCornerSize); }
			else { g.drawRect(0, 0, pictureWidth, pictureHeight); }
			
			//add loading
			var loading:Loading = new Loading();
			loading.x = pictureWidth / 2;
			loading.y = pictureHeight / 2;
			addChild(loading);
			
			//load picture
			var request:URLRequest = new URLRequest(this.url);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void {
				//remove loading
				removeChildAt(0);
				
				var bitmap:Bitmap = loader.content as Bitmap;

				if(bitmap != null) {
					//scale picture
					var divY:Number = pictureHeight / bitmap.height;
					var divX:Number = pictureWidth / bitmap.width;		
					var minDiv:Number = Math.max(divX, divY);			
					var matrix:Matrix = new Matrix();
					
					if(maintainProportions) {
						matrix.scale(minDiv, minDiv);
						var newWidth:Number = bitmap.width * minDiv;
						var newHeight:Number = bitmap.height * minDiv;	
						var diffX:Number = pictureWidth - newWidth;
						var diffY:Number = pictureHeight - newHeight;
						matrix.translate(diffX / 2, diffY / 2);					 
					} else {
						matrix.scale(divX, divY);
					}
					
					if(showBorder) { g.lineStyle(1, borderColor); }
					g.beginBitmapFill(bitmap.bitmapData, matrix);
					if(roundCornerSize > 0) { g.drawRoundRect(0, 0, pictureWidth, pictureHeight, roundCornerSize, roundCornerSize); }
					else { g.drawRect(0, 0, pictureWidth, pictureHeight); }
					g.endFill();
				}
				
				if(showBorder) {
				
					addEventListener(MouseEvent.ROLL_OVER, function(e:MouseEvent):void {  
						g.endFill();
						g.lineStyle(1, borderOverColor);
						if(roundCornerSize > 0) { g.drawRoundRect(0, 0, pictureWidth, pictureHeight, roundCornerSize, roundCornerSize); }
						else { g.drawRect(0, 0, pictureWidth, pictureHeight); }
					});
					
					addEventListener(MouseEvent.ROLL_OUT, function(e:MouseEvent):void {  
						g.endFill();
						g.lineStyle(1, borderColor);
						if(roundCornerSize > 0) { g.drawRoundRect(0, 0, pictureWidth, pictureHeight, roundCornerSize, roundCornerSize); }
						else { g.drawRect(0, 0, pictureWidth, pictureHeight); }
					});
				
				}
				
				dispatchEvent(new Event(LOAD_COMPLETE));
			});
			
			loader.load(request);
		}
		
	}
}
package mumble.timerou.timebar.display
{
	import com.google.maps.LatLngBounds;
	
	import fl.transitions.Tween;
	import fl.transitions.easing.Regular;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mumble.timerou.timebar.data.MediaBitmapLoader;
	import mumble.timerou.timebar.data.MediaData;
	import mumble.timerou.timebar.data.MediaDataLoader;
	import mumble.timerou.timebar.data.Styles;

	public class MediasBox extends Sprite {		
	
		private var _boxWidth:Number = Styles.mediaPreviewSize.x;
		private var pointerPosition:Point;
		private var maxWidth:Number;
		private var year:int;
		private var mediaDataLoader:MediaDataLoader = new MediaDataLoader();
		
		private var pointer:Sprite;
		private var box:Sprite;
		private var loading:Loading;
		private var boxTween:Tween;
		private var pointerTween:Tween;
		private var boxFadeTween:Tween;
		private var previewFadeTween:Tween;
		private var previewsContainer:Sprite;
		private var boxX:Number;
		private var boxY:Number;
		private var backButton:LinkButton;
		private var forwardButton:LinkButton;
		
		public function set boxWidth(width:Number):void {
			_boxWidth = width;
			drawBox();
		}
		public function get boxWidth():Number { return _boxWidth; }
	
		public function MediasBox() {
			loading = new Loading();
			pointer = new Sprite();
			drawPointer();
			pointer.visible = false;	
			
			addPageButtons();
			
			mediaDataLoader.addEventListener(Event.COMPLETE, drawPreviews);		
		}
		
		private function addPageButtons():void {
			backButton = new LinkButton();
			forwardButton = new LinkButton();
			
			backButton.text = "prev";
			forwardButton.text = "next";
			
			backButton.visible = false;
			forwardButton.visible = false;
			
			addChild(backButton);
			addChild(forwardButton);
			
			backButton.addEventListener(MouseEvent.CLICK, goPreviousPage);
			forwardButton.addEventListener(MouseEvent.CLICK, goNextPage);
		}
		
		private function goPreviousPage(e:MouseEvent):void {
			if(mediaDataLoader != null) {
				mediaDataLoader.loadPrevious();
			}
		}
				
		private function goNextPage(e:MouseEvent):void {
			if(mediaDataLoader != null) {
				mediaDataLoader.loadNext();
			}
		}
		
		private function drawPointer():void {
			pointer.graphics.beginFill(Styles.mediaBoxColor);
			pointer.graphics.moveTo(0, 0);
			pointer.graphics.lineTo(Styles.mediaBoxPointerSize.x / 2, Styles.mediaBoxPointerSize.y);
			pointer.graphics.lineTo((Styles.mediaBoxPointerSize.x / 2) * -1, Styles.mediaBoxPointerSize.y);
			pointer.graphics.lineTo(0, 0);
			pointer.graphics.endFill();
			
			addChild(pointer);
		}
		
		private function drawBox():void {
			if(box == null) {
				box = new Sprite();
				addChild(box);
				box.addChild(loading);
			}
			
			//if(loading != null) { box.removeChild(loading); } 
			
			boxX = pointer.x - _boxWidth / 2;
			boxY = pointerPosition.y + Styles.mediaBoxPointerSize.y;
			
			if(boxX < Styles.barMargin) {
				boxX = Styles.barMargin;
			} else if(boxX + _boxWidth > maxWidth + Styles.barMargin) {
				var delta:Number = (boxX + _boxWidth) - (maxWidth + Styles.barMargin);
				boxX -= delta;
			}
			
			box.graphics.clear();
			box.graphics.beginFill(Styles.mediaBoxColor);
			box.graphics.lineStyle();
			box.graphics.drawRoundRect(boxX, boxY, _boxWidth, Styles.mediaPreviewSize.y, Styles.mediaBoxCornerSize, Styles.mediaBoxCornerSize);
			box.graphics.endFill();
			/*box.graphics.beginFill(0xFFFFFF);
			box.graphics.drawRoundRect(
				boxX + Styles.mediaBoxLineThickness, 
				boxY + Styles.mediaBoxLineThickness, 
				_boxWidth - Styles.mediaBoxLineThickness * 2, 
				Styles.mediaPreviewSize.y - Styles.mediaBoxLineThickness * 2, 
				Styles.mediaBoxCornerSize, 
				Styles.mediaBoxCornerSize); */
			
			//adjust loading position 
			loading.x = pointer.x;
			loading.y = pointerPosition.y + Styles.mediaPreviewSize.y / 2 + Styles.mediaBoxPointerSize.y;
			
			//adjust medias position
			if(previewsContainer != null && box.contains(previewsContainer)) {
				previewsContainer.x = boxX;
				previewsContainer.width = _boxWidth;
			}
			
			//adjust buttons position;
			backButton.x = boxX;
			backButton.y = pointer.y + Styles.mediaPreviewSize.y + Styles.mediaBoxPointerSize.y;
			forwardButton.x = boxX + _boxWidth - forwardButton.width;
			forwardButton.y = pointer.y + Styles.mediaPreviewSize.y + Styles.mediaBoxPointerSize.y;
		}
		
		private function drawPreviews(e:Event = null):void {
			if(previewsContainer != null && box.contains(previewsContainer)) {
				box.removeChild(previewsContainer);
			}
			
			previewsContainer = new Sprite();
			previewsContainer.x = boxX;
			previewsContainer.y = boxY;
			box.addChild(previewsContainer);
			
			var effectiveWidth:Number = Styles.mediaPreviewSize.x - Styles.mediaBoxLineThickness * 2;
			var effectiveHeight:Number = Styles.mediaPreviewSize.y - Styles.mediaBoxLineThickness * 2;
			
			//calculate box size
			var newWidth:Number = mediaDataLoader.medias.length * (effectiveWidth + 1) + Styles.mediaBoxLineThickness * 2;
			if(mediaDataLoader.medias.length == 1) {
				newWidth--;
			}
			
			previewsContainer.graphics.beginFill(Styles.mediaBoxColor);
			previewsContainer.graphics.drawRect(0, 15, newWidth, 1);
			
			if(boxTween != null && boxTween.isPlaying) {
				boxTween.stop();
			}
			
			boxTween = new Tween(this, "boxWidth", Regular.easeOut, boxWidth, newWidth, 0.5, true)
			//draw medias
			var index:int = 0;
			for each(var mediaData:MediaData in mediaDataLoader.medias) {
				drawPreview(mediaData, index);
				index++;		
			}
			
			backButton.visible = mediaDataLoader.hasMorePagesBefore;
			forwardButton.visible = mediaDataLoader.hasMorePagesAfter;
		}
		
		private function drawPreview(mediaData:MediaData, index:int):void {
			var effectiveWidth:Number = Styles.mediaPreviewSize.x - Styles.mediaBoxLineThickness * 2;
			var effectiveHeight:Number = Styles.mediaPreviewSize.y - Styles.mediaBoxLineThickness * 2;
			
			var bitmapLoader:MediaBitmapLoader = new MediaBitmapLoader(mediaData);
				bitmapLoader.addEventListener(Event.COMPLETE, function(e:Event):void {
					if(bitmapLoader.bitmap != null) {
						var bitmap:Bitmap = bitmapLoader.bitmap;
						var previewButton:MediaPreviewButton = new MediaPreviewButton(bitmap, effectiveWidth, effectiveHeight);
						
						previewButton.x = Styles.mediaBoxLineThickness + ((effectiveWidth + 1) * index);
						previewButton.y = Styles.mediaBoxLineThickness; 
						
						previewsContainer.addChild(previewButton);		
						
						previewFadeTween = new Tween(previewButton, "alpha", Regular.easeOut, 0, 1, 0.5, true);				
					}
					loading.visible = false;
				});
				bitmapLoader.load();		
		}
		
		public function show(pointerPosition:Point):void {
			if(boxFadeTween != null && boxFadeTween.isPlaying) { boxFadeTween.stop(); }
			
			maxWidth = stage.stageWidth - Styles.barMargin * 2;			
			var newWidth:Number = Styles.mediaPreviewSize.x; //initial size
			this.pointerPosition = pointerPosition;
			//this.pointer.x = pointerPosition.x;
			pointer.y = pointerPosition.y;
			pointer.visible = true;		
			//draw boxex and display loading
			drawBox();
			
			if(boxFadeTween != null && boxFadeTween.isPlaying) { boxFadeTween.stop(); }
			boxFadeTween = new Tween(this, "alpha", Regular.easeOut, this.alpha, 1, 0.25, true);
			pointerTween = new Tween(pointer, "x", Regular.easeOut, pointer.x, pointerPosition.x, 0.5, true);		
			boxTween = new Tween(this, "boxWidth", Regular.easeOut, _boxWidth, newWidth, 0.5, true);
		}
		
		public function hide():void {
			if(boxFadeTween != null && boxFadeTween.isPlaying) { boxFadeTween.stop(); }
			boxFadeTween = new Tween(this, "alpha", Regular.easeOut, this.alpha, 0, 0.25, true);
		}
		
		public function load(bounds:LatLngBounds, year:int):void {
			if(previewsContainer != null && box.contains(previewsContainer)) {
				box.removeChild(previewsContainer);
			}
			
			loading.visible = true;
			
			//calculate pageSize
			var pageSize:int = (maxWidth) / (Styles.mediaPreviewSize.x);
			mediaDataLoader.pageSize = pageSize;
			mediaDataLoader.page = 1;
			mediaDataLoader.load(bounds, year);
		}
	}
}
package mumble.timerou.timebar.display
{
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	
	import fl.transitions.Iris;
	import fl.transitions.Transition;
	import fl.transitions.TransitionManager;
	import fl.transitions.Tween;
	import fl.transitions.easing.Regular;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mumble.timerou.timebar.data.PerYearMediaDataLoader;
	import mumble.timerou.timebar.data.Styles;
	import mumble.timerou.timebar.data.YearGroupedMediasData;
	import mumble.timerou.timebar.data.YearGroupedMediasResponse;
	
	public class Timebar extends MovieClip
	{
		private var goBackButton:LeftArrow = null;
		private var goForwardButton:RightArrow = null;
		private var bar:Sprite = null;
		private var loading:Loading;
		private var yearBoxesContainer:Sprite;
		private var yearMediasContainer:Sprite;
		
		private var referenceYear:int;
		private var direction:String;
		private var maxMediasToDisplay:int;
		private var data:YearGroupedMediasResponse;
		private var mediasBox:MediasBox = new MediasBox();
		private var yearTween:Tween;
				
		public var bounds:LatLngBounds;
		
		public function Timebar() {
			referenceYear = new Date().getFullYear();
			direction = PerYearMediaDataLoader.DIRECTION_BACK;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			addTravelButtons();
			drawBar();
			addChild(mediasBox);
		}
		
		private function addTravelButtons():void {
			if(goBackButton == null) {
				goBackButton = new LeftArrow();
				goForwardButton = new RightArrow();
				
				goBackButton.buttonMode = true;
				goForwardButton.buttonMode = true;
				
				addChild(goBackButton);
				addChild(goForwardButton);
			}

			var buttonY:int = Styles.yearMediaSize.y + Styles.yearMediaPointerSize.y + Styles.verticalMargin + Styles.yearBoxSize.y / 2;
			//Point(0,0) of arrows is center of orange points
			goBackButton.y = buttonY;
			goBackButton.x = Styles.barMargin;
			goForwardButton.y = buttonY;
			goForwardButton.x = stage.stageWidth - Styles.barMargin;
			
			goBackButton.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
				loadYears(new LatLngBounds(new LatLng(-90, -180), new LatLng(90, 180)));
			});
		}
		
		private function drawBar():void {
			if(bar == null) {
				bar = new Sprite();
				addChild(bar);
			}
			
			bar.graphics.beginFill(Styles.barColor);
			var barX:int = Styles.barMargin;
			var barY:int = Styles.yearMediaSize.y + Styles.yearMediaPointerSize.y + Styles.verticalMargin + Styles.yearBoxSize.y / 2 - Styles.barThickness / 2; //center of year boxes
			
			bar.graphics.drawRect(barX, barY, stage.stageWidth - Styles.barMargin * 2, Styles.barThickness);
		}
		
		public function loadYears(bounds:LatLngBounds):void {
			this.bounds = bounds;
			var yearMediasToLoad:int = (bar.width - Styles.yearMediaMargin * 2) / (Styles.yearMediaSize.x + Styles.yearMediaMargin);
			clearLoading();
			loading = new Loading();
			loading.x = stage.stageWidth / 2;
			loading.y = Styles.yearMediaSize.y;
			
			addChild(loading);
			
			var loader:PerYearMediaDataLoader = new PerYearMediaDataLoader();
			loader.addEventListener(Event.COMPLETE, function(e:Event):void {
				data = loader.response;
				if (data.groupedMedias.length == 1) {
					data.groupedMedias[0].x = stage.stageWidth / 2;
		        } else {
		            //calculate positions
		            var workWidth:Number = bar.width - Styles.yearMediaSize.x - Styles.yearMediaMargin * 2;
		            var yearsDelta:Number = data.maxYear - loader.response.minYear;
		            for (var i:int = 0; i < data.groupedMedias.length; i++) {
		                var delta:Number = yearsDelta - (data.maxYear - data.groupedMedias[i].year);
		                var yearX:Number = workWidth * delta / yearsDelta + Styles.yearMediaSize.x / 2;
		                data.groupedMedias[i].x = yearX + Styles.yearMediaMargin + Styles.barMargin;		                		                
		            }
		            
		            clearLoading();
		            drawYears();
		        }
			});
			loader.load(bounds, yearMediasToLoad, 2010, PerYearMediaDataLoader.DIRECTION_BACK);
		}
		
		private function drawYears():void {
			if(yearBoxesContainer != null) {
				removeChild(yearBoxesContainer);
			}
			if(yearMediasContainer != null) {
				removeChild(yearMediasContainer);
			}
			yearBoxesContainer = new Sprite();
			yearMediasContainer = new Sprite();
			
			addChild(yearBoxesContainer);
			addChild(yearMediasContainer);

			yearBoxesContainer.y = Styles.yearMediaSize.y + Styles.yearMediaPointerSize.y + Styles.verticalMargin;
			yearMediasContainer.y = 0;

			for each(var groupedMedias:YearGroupedMediasData in data.groupedMedias) {
				drawYear(yearBoxesContainer, yearMediasContainer, groupedMedias);
			}
		}
		
		private function drawYear(yearBoxesContainer:Sprite, yearMediasContainer:Sprite, groupedMedias:YearGroupedMediasData):void {
			var yearBox:YearBox = new YearBox(groupedMedias.year);
			yearBox.x = groupedMedias.x - Styles.yearBoxSize.x / 2;
			yearBoxesContainer.addChild(yearBox);
			
			var yearMedia:YearMedia = new YearMedia(groupedMedias.medias[0]);
			yearMedia.x = groupedMedias.x - Styles.yearMediaSize.x / 2;
			yearMedia.buttonMode = true;
			yearMedia.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void { showMediasBox(groupedMedias.year, groupedMedias.x); });
			yearMediasContainer.addChild(yearMedia);
			
			var transitionManager1:TransitionManager = new TransitionManager(yearBox);
			transitionManager1.startTransition({type:fl.transitions.Iris, direction:Transition.IN, duration:0.5, easing:Regular.easeOut});
			
			var transitionManager2:TransitionManager = new TransitionManager(yearMedia);
			transitionManager2.startTransition({type:fl.transitions.Iris, direction:Transition.IN, duration:0.5, easing:Regular.easeOut});

		}
		
		private function showMediasBox(year:int, positionX:Number):void {
			if(mediasBox != null) {
				mediasBox.hide();
			}
			
			var boxY:Number = 	Styles.yearMediaSize.y + 
								Styles.yearMediaPointerSize.y +
								Styles.verticalMargin + 
								Styles.yearBoxSize.y + 
								Styles.verticalMargin;								
			
			mediasBox.show(new Point(positionX, boxY));
			if(bounds != null) {
				mediasBox.load(bounds, year);
			}
		}
		
		
		private function clearLoading():void {
			if(loading != null) {
				removeChild(loading);
				loading = null;
			}
		}
	}
}
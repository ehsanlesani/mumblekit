package mumble.timerou.timebar.display
{
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	
	import fl.transitions.Transition;
	import fl.transitions.TransitionManager;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
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
	import mumble.timerou.timebar.events.MediaEvent;
	import mumble.timerou.timebar.events.TimerouMapEvent;
	import mumble.timerou.timebar.net.MapConnection;
	import mumble.timerou.timebar.utils.TimeSafeCaller;
	
	public class Timebar extends MovieClip
	{
		private var goBackButton:LeftArrow = null;
		private var goForwardButton:RightArrow = null;
		private var bar:Sprite = null;
		private var loading:Loading;
		private var yearBoxesContainer:Sprite;
		private var yearMediasContainer:Sprite;
		private var yearsTween:Tween;
		
		private var referenceYear:int;
		private var direction:String;
		private var directionAnimation:Boolean = false;
		private var maxMediasToDisplay:int;
		private var data:YearGroupedMediasResponse;
		private var mediasBox:MediasBox;
		private var yearsTween1:Tween;
		private var yearsTween2:Tween;
		private var yearsTween3:Tween;
		private var yearsTween4:Tween;
		private var yearSelectTween:Tween;
		private var stopRotation:Boolean = true;
		private var yearMedias:Array;
		private var mapConnection:MapConnection = new MapConnection();
		
		private var _year:int = new Date().getFullYear();
				
		public var currentBounds:LatLngBounds;
		public function set year(value:int):void {
			_year = value;
			selectYear();
		}
		public function get year():int { return _year; }
		
		public function Timebar() {
			//initial bounds and year
			this.referenceYear = new Date().getFullYear();
			this.currentBounds = new LatLngBounds(
				new LatLng(-90, -180),
				new LatLng(90, 180));
			
			referenceYear = new Date().getFullYear();
			mediasBox = new MediasBox(mapConnection);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function buttonsRotationLoop(e:Event):void {
			if(stopRotation) {
				if(goBackButton.rotation % 360 == 0) {
					removeEventListener(Event.ENTER_FRAME, buttonsRotationLoop);
					return;
				}
			}
			
			if(direction == PerYearMediaDataLoader.DIRECTION_BACK) {
				goBackButton.rotation -= 20;
				goForwardButton.rotation = goBackButton.rotation;
			} else if(direction == PerYearMediaDataLoader.DIRECTION_FORWARD) {
				goBackButton.rotation += 20;
				goForwardButton.rotation = goBackButton.rotation;
			}
		}
		
		private function init(e:Event):void {
			addTravelButtons();
			drawBar();
			addChild(mediasBox);
			
			mediasBox.addEventListener(MediaEvent.CLICK, function(me:MediaEvent):void { 
				dispatchEvent(new MediaEvent(MediaEvent.CLICK, me.mediaData)); 
			});
			mapConnection.addEventListener(TimerouMapEvent.BOUNDS_CHANGED, mapBoundsChanged);
		}
		
		private var timeSafeBounds:LatLngBounds = null;
		
		private function mapBoundsChanged(e:TimerouMapEvent):void {
				timeSafeBounds = e.bounds;
				TimeSafeCaller.call("Timebar.mapBoundsChanged", function():void {
					directionAnimation = false;
					loadYears(timeSafeBounds);
				});
		}
		
		private function firstTimeLoad(bounds:LatLngBounds):void {
			year = new Date().getFullYear();
			loadYears(bounds);
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
			
			goBackButton.addEventListener(MouseEvent.CLICK, goBack);
			goForwardButton.addEventListener(MouseEvent.CLICK, goForward);
		}
		
		public function goBack(e:MouseEvent = null):void {
			if(data != null) {
				if(data.hasMediasBefore) {
					stopRotation = false;					
					addEventListener(Event.ENTER_FRAME, buttonsRotationLoop); 
					
					referenceYear = data.minYear - 1;
					direction = PerYearMediaDataLoader.DIRECTION_BACK;
					directionAnimation = true;
					
					loadYears(this.currentBounds);
				}
			}
		}		  
		
		public function goForward(e:MouseEvent = null):void {
			if(data != null) {
				if(data.hasMediasAfter) {
					stopRotation = false;					
					addEventListener(Event.ENTER_FRAME, buttonsRotationLoop); 
					
					referenceYear = data.maxYear + 1;
					direction = PerYearMediaDataLoader.DIRECTION_FORWARD;
					directionAnimation = true;
					
					loadYears(this.currentBounds);
				}
			}
		}
		
		private function selectYear():void {
			if(yearMedias != null) {			
				for each(var yearMedia:YearMedia in yearMedias) {
					if(yearMedia.mediaData.year == year) {
						yearMedia.select();
						//yearSelectTween = new Tween(yearMedia, "alpha", Regular.easeOut, yearMedia.alpha, 1, 0.5, true);
					} else {
						yearMedia.unselect();
						//yearSelectTween = new Tween(yearMedia, "alpha", Regular.easeOut, yearMedia.alpha, 0.3, 0.5, true);
					}
				}
			}
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
		
		public function loadYears(newBounds:LatLngBounds):void {
			this.currentBounds = newBounds;
			mediasBox.hide();

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
		        }
		        
		        clearLoading();
	            drawYears();
				year = year;
				
				var yearMedia:YearGroupedMediasData = getGroupedMediasByYear(year);
				if(yearMedia != null) {
					showMediasBox(year, yearMedia.x);
				}
			});
			loader.load(this.currentBounds, yearMediasToLoad, referenceYear, direction != null ? direction : PerYearMediaDataLoader.DIRECTION_BACK);
		}
		
		private function getGroupedMediasByYear(year:int):YearGroupedMediasData {
			for each(var m:YearGroupedMediasData in data.groupedMedias) {
				if(m.year == year) {
					return m;
				}
			}
			
			return null;
		}
		
		private function drawYears():void {
			yearMedias = new Array();
			
			var newYearBoxesContainer:Sprite = new Sprite();
			var newYearMediasContainer:Sprite = new Sprite();
			
			addChild(newYearBoxesContainer);
			addChild(newYearMediasContainer);

			newYearBoxesContainer.y = Styles.yearMediaSize.y + Styles.yearMediaPointerSize.y + Styles.verticalMargin;
			newYearMediasContainer.y = 0;

			for each(var groupedMedias:YearGroupedMediasData in data.groupedMedias) {
				yearMedias.push(drawYear(newYearBoxesContainer, newYearMediasContainer, groupedMedias));
			}
			
			//animate by direction;
			if(directionAnimation) {
				if (direction == PerYearMediaDataLoader.DIRECTION_BACK) {
					newYearBoxesContainer.x = stage.stageWidth * -1;
					newYearMediasContainer.x = stage.stageWidth * -1;
					yearsTween1 = new Tween(newYearBoxesContainer, "x", Regular.easeOut, newYearBoxesContainer.x, 0, 0.5, true);
					yearsTween2 = new Tween(newYearMediasContainer, "x", Regular.easeOut, newYearBoxesContainer.x, 0, 0.5, true);
					yearsTween3 = new Tween(yearBoxesContainer, "x", Regular.easeOut, yearBoxesContainer.x, stage.stageWidth, 0.5, true);
					yearsTween4 = new Tween(yearMediasContainer, "x", Regular.easeOut, yearBoxesContainer.x, stage.stageWidth, 0.5, true);
					
					yearsTween4.addEventListener(TweenEvent.MOTION_FINISH, function(e:TweenEvent):void { 
						if(yearMediasContainer != null) { removeChild(yearMediasContainer); }
						if(yearBoxesContainer != null) { removeChild(yearBoxesContainer); }
						yearBoxesContainer = newYearBoxesContainer;
						yearMediasContainer = newYearMediasContainer;
						
						stopRotation = true;
					});
				} else if (direction == PerYearMediaDataLoader.DIRECTION_FORWARD) {
					newYearBoxesContainer.x = stage.stageWidth;
					newYearMediasContainer.x = stage.stageWidth;
					yearsTween1 = new Tween(newYearBoxesContainer, "x", Regular.easeOut, newYearBoxesContainer.x, 0, 0.5, true);
					yearsTween2 = new Tween(newYearMediasContainer, "x", Regular.easeOut, newYearBoxesContainer.x, 0, 0.5, true);
					yearsTween3 = new Tween(yearBoxesContainer, "x", Regular.easeOut, yearBoxesContainer.x, stage.stageWidth * -1, 0.5, true);
					yearsTween4 = new Tween(yearMediasContainer, "x", Regular.easeOut, yearBoxesContainer.x, stage.stageWidth * -1, 0.5, true);
					
					yearsTween4.addEventListener(TweenEvent.MOTION_FINISH, function(e:TweenEvent):void { 
						if(yearMediasContainer != null) { removeChild(yearMediasContainer); }
						if(yearBoxesContainer != null) { removeChild(yearBoxesContainer); }
						yearBoxesContainer = newYearBoxesContainer;
						yearMediasContainer = newYearMediasContainer;
						
						stopRotation = true;
					});
				} 
			} else {
				if(yearMediasContainer != null) { removeChild(yearMediasContainer); }
				if(yearBoxesContainer != null) { removeChild(yearBoxesContainer); }
				yearBoxesContainer = newYearBoxesContainer;
				yearMediasContainer = newYearMediasContainer;
			}
		}
		
		private function drawYear(drawingYearBoxesContainer:Sprite, drawingYearMediasContainer:Sprite, groupedMedias:YearGroupedMediasData):YearMedia {
			var yearBox:YearBox = new YearBox(groupedMedias.year);
			yearBox.x = groupedMedias.x - Styles.yearBoxSize.x / 2;
			drawingYearBoxesContainer.addChild(yearBox);
			
			var yearMedia:YearMedia = new YearMedia(groupedMedias.medias[0]);
			yearMedia.x = groupedMedias.x - Styles.yearMediaSize.x / 2;
			yearMedia.buttonMode = true;
			yearMedia.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
				year = groupedMedias.year; //select year 
				mapConnection.setYear(year); //send year to the map
				showMediasBox(groupedMedias.year, groupedMedias.x); }
			);
			drawingYearMediasContainer.addChild(yearMedia);
			
			if(!directionAnimation) {			
				var transitionManager1:TransitionManager = new TransitionManager(yearBox);
				transitionManager1.startTransition({type:fl.transitions.Iris, direction:Transition.IN, duration:0.5, easing:Regular.easeOut});
				
				var transitionManager2:TransitionManager = new TransitionManager(yearMedia);
				transitionManager2.startTransition({type:fl.transitions.Iris, direction:Transition.IN, duration:0.5, easing:Regular.easeOut});
			}

			return yearMedia;
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
			if(this.currentBounds != null) {
				mediasBox.load(this.currentBounds, year);
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
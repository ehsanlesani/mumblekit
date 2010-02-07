package mumble.timerou.map.display
{
	import com.somerandomdude.coordy.layouts.twodee.Grid;
	
	import fl.controls.TextInput;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.net.URLRequest;
	
	import mumble.timerou.map.data.PictureData;
	
	public class MediaContainer extends MovieClip 
	{
		private const BACKGROUND_COLOR:uint = 0xFFFFFF;
		private const BACKGROUND_ALPHA:Number = 1;
		private const PADDING:int = 15;
		private const MARGIN:int = 30;
		private const MINIMAP_WIDTH:int = 200;
		private const MINIMAP_HEIGHT:int = 200;
		
		private var pictures:Array = new Array();		
		private var searchInput:TextInput = null;
		private var page:int = 1;
		private var searchBitmap:Bitmap = null;
		private var pageBackwardButton:BackwardArrow = null;
		private var pageForwardButton:ForwardArrow = null;
		private var container:Sprite = null;
		private var layout:Grid = null;
		private var pageObjects:Array = new Array();
		private var pictureMargin:int = 3;
		private var displayPerPage:int = 0;
		//private var minimap:Map = null;
		
		public function MediaContainer() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event = null):void {
			stage.addEventListener(Event.RESIZE, drawAll);
			
			drawAll();
		}
		
		public function drawAll(e:Event = null):void {
			drawBackground();
			drawSearchInput();
			drawSearchButton();
			drawPageMoveButtons();
			//drawMinimap();
			setupLayout();			
			
			if(this.pictures != null) {
				this.loadPage();
			}
		}
		
		private function drawBackground():void {
			graphics.clear();
			graphics.beginFill(BACKGROUND_COLOR, BACKGROUND_ALPHA);
			graphics.drawRect(0, 0, stage.stageWidth - MARGIN, stage.stageHeight - MARGIN);
			graphics.endFill();
			
			//filters = [ new DropShadowFilter(10, 45, 0, 0.75, 8, 8, 1, 1) ];
		}
		
		private function drawSearchInput():void {
			if(searchInput == null) {
				searchInput = new TextInput();
				addChild(searchInput);
			}
			
			searchInput.x = PADDING;
			searchInput.y = PADDING;
			searchInput.width = stage.stageWidth - (PADDING * 2) - MARGIN;
		}
		
		private function drawSearchButton():void {
			if(searchBitmap == null) {
				var request:URLRequest = new URLRequest(Main.BASEURL + "Content/Images/Search.png");
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void { 
					searchBitmap = loader.content as Bitmap;
					addChild(searchBitmap);
					searchBitmap.addEventListener(MouseEvent.CLICK, search);
					drawSearchButton();
				});
				loader.load(request);
				return;
			}
			
			searchBitmap.x = stage.stageWidth - PADDING - searchBitmap.width - MARGIN;
			searchBitmap.y = PADDING; 
		}
		
		private function drawPageMoveButtons():void {
			if(pageBackwardButton == null) {
				pageBackwardButton = new BackwardArrow();
				pageForwardButton = new ForwardArrow();
				
				pageBackwardButton.width = 10;
				pageForwardButton.width = 10;
				pageBackwardButton.height = 15;
				pageForwardButton.height = 15;
				
				addChild(pageBackwardButton);
				addChild(pageForwardButton);
				
				pageBackwardButton.addEventListener(MouseEvent.CLICK, goPreviousPage);
				pageForwardButton.addEventListener(MouseEvent.CLICK, goNextPage);
			}
			
			pageBackwardButton.x = PADDING;
			pageBackwardButton.y = (stage.stageHeight - MARGIN) / 2 - pageBackwardButton.height / 2;
			
			pageForwardButton.x = (stage.stageWidth - MARGIN) - PADDING - pageForwardButton.width;
			pageForwardButton.y = (stage.stageHeight - MARGIN) / 2 - pageBackwardButton.height / 2;
		}		
		
		private function setupLayout():void {
			//get default values from picturebox
			var tempBox:PictureBox = new PictureBox(null);
			var boxWidth:int = tempBox.pictureWidth + tempBox.padding * 2 + pictureMargin;
			var boxHeight:int = tempBox.pictureHeight + tempBox.padding * 2 + tempBox.textHeight + pictureMargin;			
			
			var layoutWidth:int = stage.stageWidth - PADDING * 4 - pageBackwardButton.width - pageForwardButton.width - MARGIN;
			var layoutHeight:int = stage.stageHeight - PADDING * 4 - searchInput.height - MARGIN;
			var layoutColumns:int = layoutWidth / boxWidth;
			var layoutRows:int = layoutHeight / boxHeight;
			
			displayPerPage = layoutColumns * layoutRows;
			
			layout = new Grid(layoutWidth, layoutHeight, layoutColumns, layoutRows);
			layout.x = PADDING * 2 + pageBackwardButton.width;
			layout.y = PADDING * 2 + searchInput.height;
		}		
		
		/*private function drawMinimap():void {
			if(minimap == null) {
				minimap = new Map();
				minimap.key = Main.MAPKEY;
				minimap.setSize(new Point(MINIMAP_WIDTH, MINIMAP_HEIGHT));
				addChild(minimap);
			}
			
			minimap.x = (stage.stageWidth - MARGIN) - MINIMAP_WIDTH;
			minimap.y = (stage.stageHeight - MARGIN) - MINIMAP_HEIGHT;
		}*/
		
		private function search(e:Event = null):void {
			
		}
		
		private function loadPage():void {
			this.clearPage();
			var counter:int = 0;
			for each(var pictureData:PictureData in this.pictures) {
				var pictureBox:PictureBox = new PictureBox(pictureData);
				layout.addNode(pictureBox);
				addChild(pictureBox);	
				this.pageObjects.push(pictureBox);
				counter++;
				if(counter >= this.displayPerPage) {
					break;
				}
			}
		}
		
		private function clearPage():void {
			for each(var obj:DisplayObject in this.pageObjects) {
				removeChild(obj);
			}
			
			layout.removeAllNodes();
			this.pageObjects = new Array();
		}
		
		public function goPreviousPage(e:Event = null):void {
			page--;
			loadPage();
		}
		
		public function goNextPage(e:Event = null):void {
			page++;	
			loadPage();
		}
		
		public function load(pictures:Array):void {
			this.pictures = pictures;
			page = 0;
			loadPage();			
		}

	}
}
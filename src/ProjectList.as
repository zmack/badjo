package  {
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.StyleSheet;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ProjectList extends Sprite {
		public const AVATAR_SIZE:uint = 40;

		public var backgroundColor:uint;
		public var listWidth:uint;
		public var listHeight:uint;
		public var lateralPadding:uint = 5;
		public var bottomPadding:uint = 5;
		
		private var _items:Array;
		private var _headerText:TextField;
		private var _mask:Sprite;
		private var _container:Sprite;
		private var _controls:Sprite;
		private var _buttonSpacing:uint;
		private var _maximum_y:uint;

		public function ProjectList(options:Object) {
			this.listWidth = options.width;
			this.listHeight = options.height;
			this._buttonSpacing = 5;
			this._maximum_y = 0;
			this.backgroundColor = 0x00FFD0;
			this._items = new Array();

			this._controls = this.createScroll();
			this._mask = this.createMask();
			this._container = new Sprite();
			addChild(this._mask);
			addChild(this._container);
			addChild(this._controls);
			this._container.mask = this._mask;
		} 
		
		private function drawBackground():void {
			this.graphics.clear();
			this.graphics.beginFill(this.backgroundColor, 0.4);
			//this.graphics.lineStyle(2, 0x000000);
			this.graphics.drawRoundRect(0, 0, this.listWidth, this.listHeight, 15, 15);
		}

		public function redraw():void {
			this._maximum_y = 0;
			this._items.forEach( function(item:PickleButton, index:uint, arr:Array):void {
				this.positionButton(item);
				this._maximum_y = item.y + item.itemHeight;
			}, this);
			this.drawBackground();
		}

		public function addButton(options:Object):PickleButton {
			options.width = this.listWidth - 2 * this.lateralPadding;
			var button:PickleButton = new PickleButton(options);
			button.parentItem = this;
			this._items.push(button);
			this._container.addChild(button)
			this.positionButton(button);

			this._maximum_y = button.y + button.itemHeight;
			button.x = this.lateralPadding;

			trace(button.y);
			this.drawBackground();
			return button;
		}

		public function setHeader(options:Object):void {
			this._headerText = this.createTextField();
			this._headerText.height = AVATAR_SIZE;
			addChild(options.image);
			addChild(this._headerText);

			this._headerText.htmlText = '<h1>' + options.text + '<h1>';
			this._headerText.x = AVATAR_SIZE + this.lateralPadding*2;
			this._headerText.y = this.bottomPadding;
			this._headerText.width = this.listWidth - AVATAR_SIZE - this.lateralPadding*2;
			this._container.y = AVATAR_SIZE + this.bottomPadding;
			this._maximum_y = 0;
			options.image.y = this.bottomPadding;
			options.image.x = this.lateralPadding;
		}

		private function positionButton(button:PickleButton):void {
			button.y = this._maximum_y + this._buttonSpacing;
		}

		private function createStyleSheet():StyleSheet {
			var style:StyleSheet = new StyleSheet();

			style.parseCSS('h1 { font-family: "Trebuchet MS"; font-size: 20px; color: #000000; background-color: #FF00FF; }');
			return style;
		}

		private function createTextField():TextField {
			var text:TextField = new TextField();
			
			text.styleSheet = this.createStyleSheet();
			text.selectable = false;

			return text;
		}

		private function createMask():Sprite {
			var mask:Sprite = new Sprite;

			mask.graphics.clear();
			mask.graphics.beginFill(0x000000);
			mask.graphics.drawRoundRect(this.lateralPadding, this.getHeaderHeight() + this.bottomPadding, this.getMaskWidth(), this.getMaskHeight(), 15, 15);
			return mask;
		}

		private function getHeaderHeight():uint {
			return AVATAR_SIZE + this.bottomPadding;
		}

		private function getMaskHeight():uint {
			return this.listHeight - AVATAR_SIZE - 3 * this.bottomPadding - this._controls.height;
		}

		private function getMaskWidth():uint {
			return this.listWidth - 2 * this.lateralPadding;
		}

		private function scrollUp(e:Event):void {
			this._container.y -= 5;
		}

		private function scrollDown(e:Event):void {
			this._container.y += 5;
		}

		private function createScroll():Sprite {
			var scrollControls:Sprite = new Sprite;

			var scrollUp:Sprite = this.createScrollUp();
			var scrollDown:Sprite = this.createScrollDown();

			scrollControls.addChild(scrollUp);
			scrollControls.addChild(scrollDown);
			scrollUp.x = 30;
			scrollDown.x = 60;

			scrollControls.y = this.listHeight - scrollControls.height;

			return scrollControls;
		}

		private function createScrollUp():Sprite {
			var s:Sprite = this.createButtonyThing();

			s.addEventListener(MouseEvent.MOUSE_DOWN, this.startScrollUp);
			return s;
		}

		private function createScrollDown():Sprite {
			var s:Sprite = this.createButtonyThing();

			s.addEventListener(MouseEvent.MOUSE_DOWN, this.startScrollDown);
			return s;
		}

		private function startScrollUp(e:Event):void {
			stage.addEventListener(MouseEvent.MOUSE_UP, this.stopScroll);
			this.addEventListener(Event.ENTER_FRAME, this.scrollUp);
		}

		private function startScrollDown(e:Event):void {
			stage.addEventListener(MouseEvent.MOUSE_UP, this.stopScroll);
			this.addEventListener(Event.ENTER_FRAME, this.scrollDown);
		}

		private function stopScroll(e:Event):void {
			this.removeEventListener(Event.ENTER_FRAME, this.scrollUp);
			this.removeEventListener(Event.ENTER_FRAME, this.scrollDown);
			stage.removeEventListener(MouseEvent.MOUSE_UP, this.stopScroll);
		}

		private function createButtonyThing():Sprite {
			var s:Sprite = new Sprite();

			s.graphics.clear();
			s.graphics.beginFill(0xFFFFFF);
			s.graphics.drawRoundRect(0, 0, 15, 15, 15, 15);

			return s;
		}
	}
}

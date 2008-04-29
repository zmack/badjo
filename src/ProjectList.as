package  {
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.StyleSheet;
	
	public class ProjectList extends Sprite {
		public var backgroundColor:uint;
		public var listWidth:Number;
		public var lateralPadding:Number = 5;
		public var bottomPadding:Number = 5;

		private var _headerText:TextField;
		private var _mask:Sprite;
		private var _container:Sprite;
		private var _buttonSpacing:Number;
		private var _maximum_y:Number

		public function ProjectList() {
			this._mask = new Sprite();
			this._container = new Sprite();
			this._buttonSpacing = 5;
			this._maximum_y = 0;
			this.backgroundColor = 0x00FFD0;
			this.listWidth = 210;

			addChild(this._mask);
			addChild(this._container);
		} 
		
		private function drawBackground():void {
			this.graphics.clear();
			this.graphics.beginFill(this.backgroundColor, 0.4);
			//this.graphics.lineStyle(2, 0x000000);
			this.graphics.drawRoundRect(0, 0, this.listWidth, this._maximum_y + this.bottomPadding, 15, 15);
		}

		public function addButton(options:Object):PickleButton {
			var button:PickleButton = new PickleButton(options);
			
			this._container.addChild(button)
			this.positionButton(button);

			this._maximum_y = button.y + button.height;
			button.x = this.lateralPadding;

			trace(button.y);
			this.drawBackground();
			return button;
		}

		public function setHeader(options:Object):void {
			this._headerText = this.createTextField();
			this._headerText.height = options.image.height;
			addChild(options.image);
			addChild(this._headerText);

			this._headerText.htmlText = '<h1>' + options.text + '<h1>';
			this._headerText.x = options.image.width + this.lateralPadding*2;
			this._headerText.y = this.bottomPadding;
			this._headerText.width = this.listWidth - options.image.width - this.lateralPadding*2;
			this._maximum_y = options.image.height + this.bottomPadding;
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
	}
}

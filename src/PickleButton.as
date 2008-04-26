package  {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.StyleSheet;
	
	public class PickleButton extends Sprite {
		public var text:String;
		public var itemWidth:Number;
		public var itemHeight:Number;
		public var padding:Number;

		private var _image:Sprite;
		private var _textField:TextField;
		private var _style:StyleSheet;

		public function Project(options:Object) {
			this.itemWidth = options.width || 200;
			this.padding = options.padding || 5;

			this._image = options.image || new Sprite();
			this._textField = this.createTextField();
			this._textField.htmlText = '<p>' + (options.text || 'No text specified') + '</p>';

			this.resizeComponents();
			this.drawBackground();
			addChild(this._textField);
			addChild(this._image);
			this.addEvents();
		}

		public function drawBackground(color:uint = 0xFF00FF):void {
			this.graphics.clear();
			this.graphics.beginFill(color, 0.4);
			this.graphics.drawRoundRect(0, 0, this.itemWidth, this.itemHeight, 15, 15);
		}

		private function addEvents():void {
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}

		private function onMouseOver(e:MouseEvent):void {
			this.drawBackground(0x0F00F0);	
		}

		private function onMouseOut(e:MouseEvent):void {
			this.drawBackground();
		}

		private function createTextField():TextField {
			var text:TextField = new TextField();
			
			text.y = this.padding;
			text.styleSheet = this.createStyleSheet();
			text.multiline = true;
			text.wordWrap = true;
			text.selectable = false;

			return text;
		}

		private function resizeComponents():void {
			this.itemHeight = this._image.height + this.padding * 2;
			this._textField.x = this._image.width + this.padding;
			this._textField.width = this.itemWidth - this._image.width - this.padding;
			this._textField.height = this.itemHeight - this.padding * 2;

			this._image.x = this.padding;
			this._image.y = this.padding;
		}

		private function createStyleSheet():StyleSheet {
			var style:StyleSheet = new StyleSheet();

			style.parseCSS('p { font-family: "Trebuchet MS"; font-size: 11px; color: #000000; background-color: #FF00FF; }');

			return style;
		}

	}
}

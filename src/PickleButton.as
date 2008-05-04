package  {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.StyleSheet;
	
	public class PickleButton extends Sprite {
		public static const NORMAL_COLOR:uint = 0xFF00FF;
		public static const SELECTED_COLOR:uint = 0x0F00F0;
		public var text:String;
		public var itemWidth:Number;
		public var itemHeight:Number;
		public var padding:Number;
		public var parentItem:Object;

		private var _backgroundColor:uint;
		private var _image:Sprite;
		private var _textField:TextField;
		private var _style:StyleSheet;
		private var _resizeHeight:uint;
		private var _extendedContainer:Sprite;

		public function PickleButton(options:Object) {
			this.itemWidth = options.width || 200;
			this.padding = options.padding || 5;

			this._backgroundColor = PickleButton.NORMAL_COLOR;
			this._image = options.image || new Sprite();
			this._textField = this.createTextField();
			this._textField.htmlText = '<p>' + (options.text || 'No text specified') + '</p>';
			if ( options.extended_content != null ) {
				this._extendedContainer = options.extended_content;
			}

			this.resizeComponents();
			this.drawBackground();
			addChild(this._textField);
			addChild(this._image);
			this.addEvents();
		}

		public function drawBackground():void {
			this.graphics.clear();
			this.graphics.beginFill(this._backgroundColor, 0.4);
			this.graphics.drawRoundRect(0, 0, this.itemWidth, this.itemHeight, 15, 15);
		}

		private function addEvents():void {
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.addEventListener(MouseEvent.CLICK, onClick);
		}

		private function onMouseOver(e:MouseEvent):void {
			this._backgroundColor = PickleButton.SELECTED_COLOR;
			this.drawBackground();
		}

		private function onMouseOut(e:MouseEvent):void {
			this._backgroundColor = PickleButton.NORMAL_COLOR;
			this.drawBackground();
		}

		private function onClick(e:MouseEvent):void {
			if ( this.itemHeight == this.getExtendedHeight() ) {
				this.retract()
			} else {
				this.extend();
			}
		}
		
		private function retract():void {
			this.hideExtended();
			this.resizeTo();
		}

		private function extend():void {
			this.resizeTo(this.getExtendedHeight());
			this.displayExtended();
		}

		private function createTextField():TextField {
			var text:TextField = new TextField();
			
			text.y = this.padding;
			text.styleSheet = this.createStyleSheet();
			text.multiline = true;
			text.wordWrap = true;
			text.selectable = false;

			text.mouseEnabled = false;
			return text;
		}

		private function redraw(withParent:Boolean = false):void {
			this.drawBackground();
			if ( withParent ) (this.parentItem as ProjectList).redraw();
		}

		private function resizeTo(height:uint = 0):void {
			var item:PickleButton = this;
			height ||= this.getBaseHeight();
			this._resizeHeight = height; 

			if ( !this.hasEventListener(Event.ENTER_FRAME) ) {
				this.addEventListener(Event.ENTER_FRAME, this.resizer);
				trace("Added listener");
			} 
		}

		private function resizer(e:Event):void {
			if ( this.itemHeight < this._resizeHeight ) {
				this.itemHeight += ( (itemHeight < this._resizeHeight)? 2 : -2 );
				this.redraw(true);
			} else {
				this.itemHeight = this._resizeHeight;
				this.redraw(true);
				this.removeEventListener(Event.ENTER_FRAME, this.resizer);			
				trace("Removed listener");
			}
		}

		private function resizeComponents():void {
			this.itemHeight = this.getBaseHeight();
			this._textField.x = this._image.width + this.padding;
			this._textField.width = this.itemWidth - this._image.width - this.padding;
			this._textField.height = this.itemHeight - this.padding;

			this._image.x = this.padding;
			this._image.y = this.padding;
		}

		private function getBaseHeight():uint {
			return this._image.height + this.padding * 2;
		}

		private function getExtendedHeight():uint {
			return this.getBaseHeight() + this._extendedContainer.height + this.padding;
		}

		private function createStyleSheet():StyleSheet {
			var style:StyleSheet = new StyleSheet();

			style.parseCSS('p { font-family: "Trebuchet MS"; font-size: 11px; color: #000000; background-color: #FF00FF; }');

			return style;
		}

		private function displayExtended():void {
			this.addChild(this._extendedContainer);
			this._extendedContainer.y = this.getBaseHeight();
			this._extendedContainer.x = this.padding;
		}

		private function hideExtended():void {
			this._extendedContainer.parent.removeChild(this._extendedContainer);
		}

	}
}

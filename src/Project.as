package  {
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.StyleSheet;
	
	public class Project extends Sprite {
		public var text:String;
		public var itemWidth:Number;
		public var itemHeight:Number;

		private var _textField:TextField;
		private var _style:StyleSheet;
		
		public function Project(options:Object) {
			this.itemWidth = options.width || 200;
			this.itemHeight = options.height || 40;
			this._textField = this.createTextField();
			this._textField.htmlText = '<p>This is a little little bit of twit we do a swift</p>';

			this.draw();
			addChild(this._textField);
		}

		public function draw():void {
			this.graphics.clear();
			this.graphics.beginFill(0xFF00FF, 0.4);
			this.graphics.drawRoundRect(0, 0, this.itemWidth, this.itemHeight, 15, 15);
		}

		private function createTextField():TextField {
			var text:TextField = new TextField();
			
			text.width = this.itemWidth - 50;
			text.height = this.itemHeight - 10;
			text.x = 40;
			text.y = 5;
			text.styleSheet = this.createStyleSheet();
			text.multiline = true;
			text.wordWrap = true;

			return text;
		}

		private function createStyleSheet():StyleSheet {
			var style:StyleSheet = new StyleSheet();

			style.parseCSS('p { font-family: "Trebuchet MS"; font-size: 10px; color: #000000; background-color: #FF00FF; }');
			trace(style.getStyle('p').color);

			return style;
		}

	}
}

package  {
	import flash.display.Sprite;
	
	public class ProjectList extends Sprite {
		private var _mask:Sprite;
		private var _container:Sprite;
		private var _buttonSpacing:Number;
		private var _maximum_y:Number
		public function ProjectList() {
			this._mask = new Sprite();
			this._container = new Sprite();
			this._buttonSpacing = 5;
			this._maximum_y = 0;

			addChild(this._mask);
			addChild(this._container);
		} 

		public function addButton(options:Object):PickleButton {
			var button:PickleButton = new PickleButton(options);
			
			this._container.addChild(button)
			this.positionButton(button);

			this._maximum_y = button.y + button.height;

			trace(button.y);
			return button;
		}

		private function positionButton(button:PickleButton):void {
			button.y = this._maximum_y + this._buttonSpacing;
		}
	}
}

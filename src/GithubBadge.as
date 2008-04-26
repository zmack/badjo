package {
	import flash.display.Sprite;
	import skins.GithubBadgeSkin;
	import dataexchange.*;

	public class GithubBadge extends Sprite {

		public function GithubBadge() {
			var gw:Gateway = new Gateway();

			gw.addEventListener(GatewayEvent.DATA_RECEIVED, onDataLoaded);
			gw.getUserInfo('zmack');
			addChild(new GithubBadgeSkin.ProjectSprouts());
			trace("GithubBadge instantiated!");
		}

		private function onDataLoaded(e:GatewayEvent):void {
			trace(e);
		}
	}
}

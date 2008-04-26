package {
	import flash.display.Sprite;
	import skins.GithubBadgeSkin;
	import dataexchange.*;

	public class GithubBadge extends Sprite {

		public function GithubBadge() {
			var gw:Gateway = new Gateway();
			var p:Project = new Project({});

			addChild(p);
		}

		private function onDataLoaded(e:GatewayEvent):void {
			trace(e);
		}
	}
}

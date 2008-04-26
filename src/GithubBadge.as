package {
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import skins.GithubBadgeSkin;
	import dataexchange.*;
	/*
	{"user": 
		{	"name": "Andrei Bocan", 
			"repositories": [
				{"name": "mephisto", "url": "http://github.com/zmack/mephisto", "description": "A mirror of the mephisto code-base", "homepage": "http://mephistoblog.com/"}
			], 
			"blog": "http://spinach.andascarygoat.com", 
			"login": "zmack", 
			"email": "zmaxor@gmail.com", 
			"location": "Bucharest, Romania"
		}
	}
	*/
	public class GithubBadge extends Sprite {

		public function GithubBadge() {
			var gw:Gateway = new Gateway();
			var s:Sprite = new Sprite();

			var pl:ProjectList = new ProjectList();
			pl.setHeader({image: SpriteWrapper(new GithubBadgeSkin.ZmAvatar()), text: "Zmack"});
			pl.addButton({image: SpriteWrapper(new GithubBadgeSkin.PublicProject()), text: "Pickles are tasty and nice and pretty damn tasty"});
			pl.addButton({image: SpriteWrapper(new GithubBadgeSkin.PublicProject()), text: "Pickles are tasty and nice and pretty damn tasty"});
			pl.addButton({image: SpriteWrapper(new GithubBadgeSkin.PublicProject()), text: "Pickles are tasty and nice and pretty damn tasty"});
			pl.addButton({image: SpriteWrapper(new GithubBadgeSkin.PublicProject()), text: "Pickles are tasty and nice and pretty damn tasty"});
			pl.addButton({image: SpriteWrapper(new GithubBadgeSkin.PublicProject()), text: "Pickles are tasty and nice and pretty damn tasty"});
			pl.addButton({image: SpriteWrapper(new GithubBadgeSkin.PublicProject()), text: "Pickles are tasty and nice and pretty damn tasty"});

			addChild(pl);
			pl.y = 20;
		}

		private function onDataLoaded(e:GatewayEvent):void {
			trace(e);
		}

		private function SpriteWrapper(d:DisplayObject):Sprite {
			var s:Sprite = new Sprite();
			s.addChild(d);

			return s;
		}
	}
}

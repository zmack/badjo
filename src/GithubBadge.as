package {
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import skins.GithubBadgeSkin;
	import dataexchange.*;
	import com.adobe.serialization.json.JSON;

	/*
	Data looks pretty much like this: 

	{"user": 
		{	"name": "Andrei Bocan", 
			"repositories": 
			[
				{"name": "badjo", "url": "http://github.com/zmack/badjo", "description": "Github flash badge ", "homepage": ""},
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
			var user:Object = getUserObject();

			pl.setHeader({image: SpriteWrapper(new GithubBadgeSkin.ZmAvatar()), text: user.name });
			user.repositories.forEach( function(repo:Object, index:uint, arr:Array):void {
				pl.addButton({image: SpriteWrapper(new GithubBadgeSkin.PublicProject()), text: repo.name });
			});

			addChild(pl);
			pl.y = 20;
		}

		private function onDataLoaded(e:GatewayEvent):void {
			trace(e);
		}

		private function getUserObject(json:String = null):Object {
			// Cheesy loading of cheesy test data
			json ||= '{"user": {"name": "Andrei Bocan", "repositories": [{"name": "mephisto", "url": "http://github.com/zmack/mephisto", "description": "A mirror of the mephisto code-base", "homepage": "http://mephistoblog.com/"}, {"name": "badjo", "url": "http://github.com/zmack/badjo", "description": "Github flash badge ", "homepage": ""}], "blog": "http://spinach.andascarygoat.com", "login": "zmack", "email": "zmaxor@gmail.com", "location": "Bucharest, Romania"}}';
			return JSON.decode(json).user;
		}

		private function SpriteWrapper(d:DisplayObject):Sprite {
			var s:Sprite = new Sprite();
			s.addChild(d);

			return s;
		}
	}
}

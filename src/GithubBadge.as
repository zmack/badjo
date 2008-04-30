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
		private var _gw:Gateway;
		private var _pl:ProjectList;

		public function GithubBadge() {
			_gw = new Gateway();
			
			_pl = new ProjectList();
			addChild(_pl);
			_pl.y = 20;

			this.requestData('evilchelu');
		}

		private function onDataLoaded(e:GatewayEvent):void {
			trace(e);
		}

		private function displayProjectList(user:Object):void {
			_pl.setHeader({image: SpriteWrapper(new GithubBadgeSkin.ZmAvatar()), text: user.name });
			user.repositories.forEach( function(repo:Object, index:uint, arr:Array):void {
				_pl.addButton({image: SpriteWrapper(new GithubBadgeSkin.PublicProject()), text: repo.name });
			});
		}

		private function displayError():void {

		}

		private function getUserObject(json:String = null):Object {
			// Cheesy loading of cheesy test data
			json ||= '{"user": {"name": "Andrei Bocan", "repositories": [{"name": "mephisto", "url": "http://github.com/zmack/mephisto", "description": "A mirror of the mephisto code-base", "homepage": "http://mephistoblog.com/"}, {"name": "badjo", "url": "http://github.com/zmack/badjo", "description": "Github flash badge ", "homepage": ""}], "blog": "http://spinach.andascarygoat.com", "login": "zmack", "email": "zmaxor@gmail.com", "location": "Bucharest, Romania"}}';
			return JSON.decode(json).user;
		}

		private function requestData(user:String):void {
			_gw.getUserInfo(user);
			_gw.addEventListener(GatewayEvent.DATA_RECEIVED, dataLoaded);
		}

		private function dataLoaded(e:GatewayEvent):void {
			if ( e.succeeded ) {
				displayProjectList(JSON.decode(e.data).user);
			} else {
				addChild(SpriteWrapper(new GithubBadgeSkin.OctocatImage()));
			}
			trace(e.data);
		}

		private function SpriteWrapper(d:DisplayObject):Sprite {
			var s:Sprite = new Sprite();
			s.addChild(d);

			return s;
		}
	}
}

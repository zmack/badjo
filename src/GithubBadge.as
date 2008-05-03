package {
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.LoaderInfo;
	import flash.net.URLRequest;
	import skins.GithubBadgeSkin;
	import dataexchange.*;
	import com.adobe.serialization.json.JSON;
	import com.adobe.crypto.MD5;
	import flash.external.ExternalInterface;	

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
		private var _user:String;

		public function GithubBadge() {
			var user:String;
			addExternalInterface();

			try {
				user = getParams().gitUser;
			} catch (e:Error) {
				user = 'evilchelu';
			}

			_gw = new Gateway();
			
			this.requestData(user || 'zmack');
		}

		private function addExternalInterface():void {
			if ( ExternalInterface.available ) {
				ExternalInterface.addCallback("requestData",requestData);
			}
		}

		private function getParams():Object {
			return LoaderInfo(this.loaderInfo).parameters;
		}

		private function onDataLoaded(e:GatewayEvent):void {
			trace(e);
		}

		private function displayProjectList(user:Object):void {
			if ( _pl != null ) _pl.parent.removeChild(_pl);
			_pl = new ProjectList()

			_pl.setHeader({image: SpriteWrapper(loadAvatar('http://www.gravatar.com/avatar/' + MD5.hash(user.email) + '?s=40')), text: user.name });
			user.repositories.forEach( function(repo:Object, index:uint, arr:Array):void {
				_pl.addButton({image: SpriteWrapper(new GithubBadgeSkin.PublicProject()), text: repo.name });
			});

			addChild(_pl);
		}

		private function displayError():void {
			_pl.addChild(SpriteWrapper(new GithubBadgeSkin.OctocatImage()));
		}

		private function requestData(user:String):void {
			_user = user;
			_gw.getUserInfo(user);
			_gw.addEventListener(GatewayEvent.DATA_RECEIVED, dataLoaded);
		}

		private function dataLoaded(e:GatewayEvent):void {
			if ( e.succeeded ) {
				displayProjectList(JSON.decode(e.data).user);
			} else {
				displayError();
			}
		}

		private function SpriteWrapper(d:DisplayObject):Sprite {
			var s:Sprite = new Sprite();
			s.addChild(d);

			return s;
		}

		private function loadAvatar(url:String):DisplayObject {
			var request:URLRequest = new URLRequest(url);
			var loader:Loader = new Loader();
			loader.load(request);
			return loader;
		}
	}
}

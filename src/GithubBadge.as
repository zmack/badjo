package {
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.LoaderInfo;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.StyleSheet;
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
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			addExternalInterface();

			try {
				user = getParams().gitUser;
			} catch (e:Error) {
				user = 'evilchelu';
			}

			_gw = new Gateway();
			
			this.requestData(user || 'defunkt');
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
			_pl = new ProjectList({ width: stage.stageWidth, height: stage.stageHeight })

			_pl.setHeader({image: SpriteWrapper(loadAvatar('http://www.gravatar.com/avatar/' + MD5.hash(user.email || '') + '?s=40')), text: user.name || user.login });
			user.repositories.forEach( function(repo:Object, index:uint, arr:Array):void {
				_pl.addButton({
					image: SpriteWrapper(new GithubBadgeSkin.PublicProject()), 
					text: repo.name,
					extended_content: SpriteWrapper(this.createTextField(repo.description || 'No description'))
				});
			}, this);

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

		private function createStyleSheet():StyleSheet {
			var style:StyleSheet = new StyleSheet();

			style.parseCSS('p { font-family: "Trebuchet MS"; font-size: 10px; color: #000000; background-color: #FF00FF; }');
			return style;
		}

		private function createTextField(text:String):TextField {
			var textField:TextField = new TextField();
			
			textField.width = stage.stageWidth - 20; // FIXME: dirty hardcode business.
			textField.height = 0;
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.wordWrap = true;
			textField.styleSheet = this.createStyleSheet();
			textField.selectable = false;
			textField.htmlText = '<p>' + text + '</p>';

			return textField;
		}
	}
}

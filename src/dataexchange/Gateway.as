package dataexchange {
  import flash.events.*;
  import flash.net.URLRequest;
  import flash.net.URLLoader;
  import flash.net.URLRequestMethod;
  import flash.net.URLRequestHeader;
  import flash.utils.*;
  
  import com.adobe.serialization.json.JSON;

  public class Gateway extends EventDispatcher {   
		private var _baseUrl:String;
		private var _loader:URLLoader;
    
    public function Gateway(options:Object = null) {
      options ||= {};
      this._baseUrl = options.base_url || "http://github.com/api/v1/json/";
    }
		
		public function getUserInfo(username:String):void {
			this.requestData(username);
		}
		
    private function requestData(requestString:String):void {
      /*var requestString:String = "/pages/1.json";*/
      var request:URLRequest = new URLRequest(this._baseUrl + requestString);
			request.contentType = "application/json";
      request.method = URLRequestMethod.GET;

      this._loader = new URLLoader(request);
      this._loader.addEventListener(Event.COMPLETE, dataLoaded);
    }

    private function dataLoaded(event:Event):void {
      trace("Data Received => " + this._loader.data);
      trace("Data Loaded ! => " + JSON.decode(this._loader.data).panels);
			trace(event);
			var newEvent:GatewayEvent = new GatewayEvent(GatewayEvent.DATA_RECEIVED, (event.target as URLLoader).data);
			dispatchEvent(newEvent);
    }
		
		private function dataError(event:Event):void {
			var newEvent:GatewayEvent = new GatewayEvent(GatewayEvent.DATA_RECEIVED, null, false);
			dispatchEvent(newEvent);
		}
  }
}

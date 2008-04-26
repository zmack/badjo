package dataexchange {
	import flash.events.Event;
	
	public class GatewayEvent extends Event {
		public static const DATA_RECEIVED:String = "gotData";
		
		public var data:String;
		
		public function GatewayEvent(type:String, data:String = null, succeeded:Boolean = true) {
			super(type);
			this.data = data;
		}
		
		public override function clone():Event {
			return new GatewayEvent(this.type, this.data);
		}
	}
}

package dataexchange {

	import asunit.framework.TestCase;

	public class GatewayEventTest extends TestCase {
		private var instance:GatewayEvent;

		public function GatewayEventTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			instance = new GatewayEvent();
		}

		override protected function tearDown():void {
			super.tearDown();
			instance = null;
		}

		public function testInstantiated():void {
			assertTrue("instance is GatewayEvent", instance is GatewayEvent);
		}

		public function testFailure():void {
			assertTrue("Failing test", false);
		}
	}
}
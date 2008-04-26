package dataexchange {

	import asunit.framework.TestCase;

	public class GatewayTest extends TestCase {
		private var gateway:Gateway;

		public function GatewayTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			gateway = new Gateway();
		}

		override protected function tearDown():void {
			super.tearDown();
			gateway = null;
		}

		public function testInstantiated():void {
			assertTrue("gateway is Gateway", gateway is Gateway);
		}

		public function testFailure():void {
			assertTrue("Failing test", false);
		}
	}
}
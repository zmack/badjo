package  {

	import asunit.framework.TestCase;

	public class ProjectListTest extends TestCase {
		private var instance:ProjectList;

		public function ProjectListTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			instance = new ProjectList();
		}

		override protected function tearDown():void {
			super.tearDown();
			instance = null;
		}

		public function testInstantiated():void {
			assertTrue("instance is ProjectList", instance is ProjectList);
		}

		public function testFailure():void {
			assertTrue("Failing test", false);
		}
	}
}
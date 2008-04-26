package  {

	import asunit.framework.TestCase;

	public class ProjectTest extends TestCase {
		private var project:Project;

		public function ProjectTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			project = new Project();
		}

		override protected function tearDown():void {
			super.tearDown();
			project = null;
		}

		public function testInstantiated():void {
			assertTrue("project is Project", project is Project);
		}

		public function testFailure():void {
			assertTrue("Failing test", false);
		}
	}
}
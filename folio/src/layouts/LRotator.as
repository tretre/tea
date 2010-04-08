package layouts
{
	public class LRotator extends Layout
	{
		public function LRotator():void{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			
		}
	}
}
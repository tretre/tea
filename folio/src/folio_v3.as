package {
		import flash.display.*;
		import flash.events.*;
		import flash.filters.*;
		import flash.text.*;
		
		import utils.*;

		/**
		 * ...
		 * @author tre
		 */
		[SWF(width=900, height=500, frameRate=30, backgroundColor='#FFFFFF')]

		public class folio_v3 extends MovieClip 
		{
			private var engine:Engine;
			
			public function folio_v3():void 
			{
				if (stage) init();
				else addEventListener(Event.ADDED_TO_STAGE, init);
			}
			
			private function init(e:Event = null):void 
			{
				removeEventListener(Event.ADDED_TO_STAGE, init);
				engine = new Engine();
				addChild(engine);
			}
		}
	}

package utils{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.text.*;
	import flash.utils.Timer;
	
	import layouts.*;
	
	import ui.ProgAtom;
	
	import utils.*;

	public class Engine extends MovieClip{
		
		public var layout:LCutout;
		public var progbar:ProgAtom;
		public var timer:Timer;
		public var assets:AssetManager;
		public var stg_h:Number;
		public var stg_w:Number;
		
		public function Engine(){
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event = null):void{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stg_w = stage.stageWidth;
			stg_h = stage.stageHeight;
			assets = new AssetManager(this);
			layout = new LCutout(this);
			progbar = new ProgAtom(this);
			//timer = new Timer(10, progbar.itemLength);
			setup();
		}
		
		private function setup():void{
			//assetLoader.addProgBar(progbar);
			stage.addEventListener(MouseEvent.CLICK, onMouseClick);
			stage.addEventListener(Event.ENTER_FRAME, update);
			//timer.addEventListener(TimerEvent.TIMER, timeListener);
			//timer.start();
		}
		
		//~~~oOo~~~----------~~~oIo~~~----------~~~oOo~~~//
		////										   ////
		//////			  EVENT FUNCTIONS 			 //////
		////										   ////
		//~~~oOo~~~----------~~~oIo~~~----------~~~oOo~~~//
		
		private function update(event:Event):void {
			layout.update(event);
		}
		
		private function onMouseClick(event:MouseEvent):void {
			layout.click(event);
		}
		
		private function timeListener(event:TimerEvent):void{
			//progbar.update(100/progbar.itemLength * timer.currentCount)
		}
		
		
		//~~~oOo~~~----------~~~oIo~~~----------~~~oOo~~~//
		////										   ////
		//////			  	  HELPERS    			 //////
		////										   ////
		//~~~oOo~~~----------~~~oIo~~~----------~~~oOo~~~//
		
		public function get Layout():LCutout{
			return layout;
		}
		
		public function cout(id:String, text:String):void{
			trace(id + " >> " + text);
		}
	}
}
package utils
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;

	public class Preloader extends Sprite{
		
		private var request:URLRequest;
		private var loader:Loader;
		
		public function Preloader(){
			request = new URLRequest("Min.swf");
			loader = new Loader();
			
			loader.load(request);
			this.addChild(loader);
			
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadProgress);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadError);
		}
		
		private function loadProgress(e:ProgressEvent):void{
			var percentLoaded:Number = Math.round(e.bytesLoaded / e.bytesTotal * 100);
			trace(".# PRELOADER: Load Progress @ "+ percentLoaded + "% #.")
		}
		
		private function loadComplete(e:Event):void{
			trace(".# PRELOADER: Load Complete #.")
			
		}
		
		private function loadError(e:ErrorEvent):void{
			trace(".# PRELOADER: Load Error #.");
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, loadProgress);
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadComplete);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loadError);
			delete this;
		}	
	}
}
package utils
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.text.*;
	
	public class Preloader extends MovieClip{
		
		private var request:URLRequest;
		private var loader:Loader;
		private var textBox:TextField;
		private var format:TextFormat;
		private var futura:visitor_font;
		
		public function Preloader(){
			request = new URLRequest("Min.swf");
			loader = new Loader();
			
			textBox = new TextField();
				textBox.selectable = false;
				textBox.width = stage.stageWidth;
				textBox.y = stage.stageHeight/2 - 40;
				textBox.antiAliasType = AntiAliasType.ADVANCED;
				
			format = new TextFormat();
				
				format.font = "Visitor TT1 BRK";
				format.align = TextFormatAlign.CENTER;
				format.size = 12;
				
				
				textBox.text = "What is going on?";
				textBox.setTextFormat(format);
				textBox.embedFonts = true;

			
			loader.load(request);
			this.addChild(loader);
			this.addChild(textBox);
			
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadProgress);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadError);
		}
		
		private function loadProgress(e:ProgressEvent):void{
			var percentLoaded:Number = Math.round(e.bytesLoaded / e.bytesTotal * 100);
			
			//trace(".# PRELOADER: Load Progress @ "+ percentLoaded + "% #.")
			textBox.text = "PRELOADER: Load Progress @ "+ percentLoaded + "%";
			textBox.setTextFormat(format);
		}
		
		private function loadComplete(e:Event):void{
			trace(".# PRELOADER: Load Complete #.")
			
		}
		
		private function loadError(e:ErrorEvent):void{
			trace(".# PRELOADER: Load Error #.");
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, loadProgress);
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadComplete);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loadError);
			textBox.text = "Load Failed... Please Contact Your Designer!"
			textBox.setTextFormat(format);
			//delete this;
		}	
	}
}
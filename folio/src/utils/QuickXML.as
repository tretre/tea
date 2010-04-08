package utils
{
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class QuickXML
	{
		private var xmlLoader:URLLoader;
		private var xmlData:XML;
		private var xmlArray:Array;
		private var listName:String;
		
		public function QuickXML():void{
			xmlArray = new Array();
		}
		
		public function loadXML(name:String):void{
			xmlLoader = new URLLoader();
			//xmlData = new XML();
			listName = name;
			xmlLoader.addEventListener(Event.COMPLETE, onXMLLoaded);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, onLoadError); 
			xmlLoader.load(new URLRequest("../lib/" + name + ".xml"));
		}
		
		private function onXMLLoaded(e:Event):void {
			xmlArray[listName] = new XML(e.target.data);
			trace("XML " + listName + " added.");
		}
		
		private function onLoadError(e:IOErrorEvent):void{
			trace("QuickXML " + listName + ".xml could not be loaded");
		}
		
		public function getXML(name:String):XML{
			if(xmlArray[name]){
				return xmlArray[name];
			}
			return null;
		}
		
			
	}
}
package utils
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.utils.*;
	
	public class AssetManager
	{
		private var caller:MovieClip;
		private var stage:Stage;
		private var assets:Array;
		private var	layers:Array;
		private var loader:Loader;
			private var loadName:String;
			private var loadLayer:String;
			private var loadIndex:int;
		private var stgW:Number;
		private var stgH:Number;
		private var strictWidth:Number;
		private var strictHeight:Number;
		//private var assetLoader:AssetLoader;
		//private var progBar:ProgBar
		
		public function AssetManager(caller:* = null):void{
			this.caller 		= caller;
			this.stage 			= caller.stage;
			stgW				= this.stage.stageWidth;
			stgH				= this.stage.stageHeight;
			assets				= new Array();
			layers				= new Array();
			loader				= new Loader();
			strictWidth			= stgW;
			strictHeight		= stgH;
		//	progBar = new ProgAtom(g_caller);
		//	assetLoader = new AssetLoader(g_caller);
		//	assetLoader.addProgBar(progbar);
		}
		
		public function newLayer(name:String):void{
			if (layers[name] != undefined){
				cout("Layer " + name + " already exists.");
				return;
			}
			cout("Layer " + name + " created.");
			var l:Sprite = new Sprite();
			l.name = name;
			caller.addChild(l);
			layers[name] = l;
		}
		
		public function newAsset(name:String = null, type:* = null):*{
			var _asset:* = getAsset(name);
			
			if(_asset){	
				cout("Asset " + name + "  already exists");
				//assets[name] = type;				
			} else {
				cout("Asset " + name + " created.");
				var a:Object = new Object;
				a.name = name;
				a.asset = type;
				assets.push(a);
				_asset = a.asset;
			}
			
			return _asset;
		}
		
		public function addAsset(layer:*, asset:*, index:int = -1):void{
			cout("Asset added.");
			//if(layer.contains(asset as DisplayObject)){
				if (index == -1){
					layer.addChild(asset);
				} else {
					layer.addChildAt(asset, index);
				}
			//}
		}
		
		//~~~oOo~~~----------~~~oIo~~~----------~~~oOo~~~//
		////										   ////
		//////		       LOADING EVENT    		 //////
		////										   ////
		//~~~oOo~~~----------~~~oIo~~~----------~~~oOo~~~//
		
		public function loadAsset(asset:String, fileName:String):void{
			loadName 	= asset;
			loader.load(new URLRequest(fileName));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			loader.contentLoaderInfo.addEventListener(Event.INIT, onLoadInit);
		}
		
		private function onLoadComplete(e:Event):void{
			var content:Sprite = new Sprite();
			newAsset(loadName + "_content", loader.content);
			content.addChild(getAsset(loadName + "_content"));
			newAsset(loadName, content);
			
			//cout(getAsset(loadName));
			//addAsset(getLayer(loadLayer), getAsset(loadName), loadIndex);
			//addAsset(getAsset(loadName), loader.content);
			caller.layout.assetSender(loadName);
		}
		
		private function onLoadProgress(e:ProgressEvent):void{
			var perc:Number = Math.round((e.bytesLoaded / e.bytesTotal) * 100);
			//cout("Loader: " + perc + "%");
		}
		
		private function onLoadInit(e:Event):void{
			cout("Asset Init Complete");
			
		}
		
		//~~~oOo~~~----------~~~oIo~~~----------~~~oOo~~~//
		////										   ////
		//////		       RETURN HELPERS    		 //////
		////										   ////
		//~~~oOo~~~----------~~~oIo~~~----------~~~oOo~~~//
		
		public function getAsset(name:String):*{
			for each (var o:Object in assets) {
				if (o.name == name) {
					cout("Asset " + o.name + "(" + o.asset + ") returned.");
					return o.asset;
				}
			}
			return null;
		}
		
		
		public function getLayer(name:String):Sprite{
			if(layers[name]){
				cout("Layer " + name + " returned.");
				return layers[name];
			}
			return null;
		}
		
		public function getSize(name:String):Rectangle{
			if(assets[name] != null){
				return new Rectangle(0, 0, assets[name].width, assets[name].height);
			}
			return null;
		}
		
		public function clone(s:*):void{
			var b:BitmapData = new BitmapData(s.width, s.height, true, 0x0);
			b.draw(s);
			var bitmap:Bitmap = new Bitmap(b);
			
		}
		
		//~~~oOo~~~----------~~~oIo~~~----------~~~oOo~~~//
		////										   ////
		//////		     GRAPHICAL HELPERS  		 //////
		////										   ////
		//~~~oOo~~~----------~~~oIo~~~----------~~~oOo~~~//
		
		public function hide(layer:String, asset:String = null):void{
			if(layers[layer] == null){return;}
			
			if(asset == null){layers[layer].visible = false;} 
			else {assets[asset].visible = false;}
		}
		
		public function show(layer:String, asset:String = null):void{
			if(layers[layer] == null){return;}
			
			if(asset == null){layers[layer].visible = true;} 
			else {assets[asset].visible = true;}
		}
		
		public function setSizeLimit(w:Number, h:Number):void{
			strictWidth = w;
			strictHeight = h;
		}
		
		//~~~oOo~~~----------~~~oIo~~~----------~~~oOo~~~//
		////										   ////
		//////		          HELPERS  		         //////
		////										   ////
		//~~~oOo~~~----------~~~oIo~~~----------~~~oOo~~~//
		
		private function cout(text:String = ""):void{
			caller.cout(getQualifiedClassName(this), text);
		}
	}
}
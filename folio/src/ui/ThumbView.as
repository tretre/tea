package ui
{
	import flash.display.*;
	import flash.utils.*;
	
	import utils.*;
	
	public class ThumbView
	{
		private var caller:*;
		private var itemArray:Array;
		private var assets:AssetManager;
		
		public function ThumbView(caller:* = null){
			this.caller = caller;
			cout("ThumbView Added");
			itemArray = new Array();
			assets = caller.assets;
			assets.newLayer("thumb");
		}
		
		public function addThumb(asset:*):void{
			//assets.newAsset(
			//assets.addAsset(assets.getLayer("thumb"), assets.getAsset("thumb" + itemArray.length));
			
			//var a:* = assets.getAsset("thumb" + itemArray.length);
			var a:* = asset;
			cout(a);
			a.scaleX = a.scaleY = 1;
			if(a.height >= a.width){
				if(a.height > 50){
					var loaderH:Number = 50/a.height; 
					a.scaleX = a.scaleY = loaderH;
				}
			} else if (a.height < a.width){
				if (a.width > 50) {
					var loaderW:Number = 50/a.width;
					a.scaleX = a.scaleY = loaderW;
				}
			}
			
			cout("width, height :: " + a.width + ", " + a.height);
			//g_assets.addAsset("thumb" + itemArray.length, "thumb", image);
			itemArray.push(asset);
		}
		
		
		
	/*	public function hide():void{
			this.visible = false;
		}
		
		private function show():void{
			this.visible = true;
		}
	*/
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
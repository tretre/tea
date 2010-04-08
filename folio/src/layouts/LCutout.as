package layouts
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.text.*;
	import flash.utils.*;
	
	import ui.*;
	
	import utils.*;
	/**
	 * ...
	 * @author tre
	 */
	public class LCutout
	{
		//private
		private var caller:*;
		private var tabHolder:MovieClip;
		private var txtVec:Vector.<TextField>;
		private var fmt:TextFormat;
		private var tabArr:Array;
		private var tabIO:Array;
		private var bbArr:Array;
		private var dropShadow:DropShadowFilter;
		private var threesquares:Array;
		private var imgFrame:MovieClip;
		//private var loader:Loader;
		private var barMC:MovieClip;
		private var waver1:Number;
		private var waver2:Number;
		private var isWaver1Growing:Boolean;
		private var isWaver2Growing:Boolean;
		//[Embed(source='../lib/VISITOR1.ttf', fontName = 'visitor', mimeType="application/x-font")]
		//private var visitor:Class;
		private var futura:visitor_font;
		private var assets:AssetManager;
		private var thumbs:ThumbView;
		private var g_xml:QuickXML;
		private var currImage:DisplayObject;
		private var imageArray:Array;
		//private var assets:AssetLoader;
		private var stg:Stage;
		private var stg_w:Number;
		private var stg_h:Number;
		
		private var borderSize:Number;
		//public
		

		//private
		public function LCutout(caller:*):void {
			this.caller = caller;
			setup();
		}
		
		private function setup():void {
			//removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stg				= caller.stage;
			stg_w			= stg.stageWidth;
			stg_h			= stg.stageHeight;
			//assets	= new AssetLoader(stg);
			
			waver1 = 0;
			waver2 = 0;
			//addBackground();
			//imgFrame 		= new MovieClip();
			//stg.addChild(imgFrame);
			//imgFrame.opaqueBackground = 0x000000;
			tabHolder 		= new MovieClip();
			stg.addChild(tabHolder);
			
			assets 	= caller.assets;
			assets.newLayer("frame");
			//assets.addHolder("frame");
			assets.setSizeLimit(600, 300);
			
			g_xml	= new QuickXML();
			g_xml.loadXML("images");
			
			fmt 			= new TextFormat();
			tabArr 			= new Array();
			bbArr 			= new Array();
			tabIO 			= new Array();
			
			imageArray		= new Array();
			
			borderSize		= 20;
			
			dropShadow 		= new DropShadowFilter();
			dropShadow.alpha = 0.30;
			dropShadow.blurX = dropShadow.blurY = 20;
			threesquares 	= new Array(new MovieClip, new MovieClip, new MovieClip);
			thumbs			= new ThumbView(caller);
			
			assets.getLayer("frame").filters = new Array(dropShadow);
			
			
			buildMenu();
			
			fmt.font = "Visitor TT1 BRK";
			fmt.size = 10;
			//stage.addEventListener(MouseEvent.ROLL_OVER, mouseOver);
			//stage.addEventListener(MouseEvent.ROLL_OUT, mouseOut);
			//stage.addEventListener(MouseEvent.CLICK, onMouseClick);
			//addEventListener(Event.ENTER_FRAME, update);
			//tabHolder.filters = new Array(dropShadow);
		}
		
		private function buildMenu():void {
			barMC = new MovieClip();
			//imageLoader("RainGod");
			//graphics.beginFill(0x0033FF); //blue
			//graphics.beginFill(0x0033FF); //crimson
			//graphics.beginFill(0xFFCC00); //yellow
			//graphics.beginFill(0x33DD00); //green
			//graphics.drawRect(32, 20, stg_w - 64, stg_h - 40);
			//graphics.endFill();
			addBar(0, 0);
			//tabMC.graphics.beginFill(0xFF3300);
			addSquares(false, false);
			//tabMC.graphics.endFill();
			barMC.filters = new Array(dropShadow);
			//tabArr.push(tabMC);
			addTabs(7);
			tabHolder.addChild(barMC);
			barMC.addChild(threesquares[0]);
			barMC.addChild(threesquares[1]);
			barMC.addChild(threesquares[2]);
			buildThumbs();
		}
		
		private function buildThumbs():void{
			cout("Thumbs Building.");
			cout(g_xml.getXML("images"));
			for each(var a:* in g_xml.getXML("images")){
				cout("XML item: " + a);
			}
		}
		
		private function addBar(i:Number, j:Number):void {
			barMC.graphics.clear();
			barMC.graphics.lineStyle(0, 0xFFFFFF);
			barMC.graphics.beginFill(0xFFFFFF);
			barMC.graphics.moveTo(20 + i, 15 - j/3);
			barMC.graphics.lineTo(15 - i, 85 - j);
			barMC.graphics.lineTo(100 + i/2, 75 + j/(Math.abs(i)+1));
			barMC.graphics.lineTo(125 + j, 50 + i);
			barMC.graphics.lineTo(stg_w - 40 + j, 40 + i);
			barMC.graphics.lineTo(stg_w - 40 + i, 85 + j);
			barMC.graphics.lineTo(stg_w - 20 + j, 80 + i);
			barMC.graphics.lineTo(stg_w - 20, 20);
			barMC.graphics.lineTo(20 + i, 15 - j/3);
			barMC.graphics.endFill();
		}
		
		private function addSquares(a:Boolean, b:Boolean):void {
			var filled:uint;
			threesquares[0].graphics.clear();
			threesquares[1].graphics.clear();
			threesquares[2].graphics.clear();
			if (a && !b) filled = 0;
			else if (!a && b) filled = 1;
			else if (a && b) filled = 2;
			else filled = 3
			for (var i:uint = 0; i < 3; i++) {
				threesquares[i].graphics.lineStyle(1, 0xFF3300);
				if (i == filled) {
					threesquares[i].graphics.beginFill(0xFF3300);
				}
				var xaxis:uint = 15 * (i + 1) + 15;
				threesquares[i].graphics.drawRect(30, 30 + (15 * i), 10, 10);
				threesquares[i].alpha = 0.1;
				//threesquares[i].graphics.drawRect(xaxis, 45, 10, 10);
				//threesquares[i].graphics.drawRect(xaxis, 60, 10, 10);
			}
			threesquares.filters = new Array(dropShadow);
		}
		
		private function addTabs(numTabs:uint = 3):void {
			for (var i:uint = 0; i < numTabs; i++) {
				var tabMC:MovieClip = new MovieClip();
				var maskMC:MovieClip = new MovieClip();
				var bbMC:Sprite = new Sprite();
				var txtMC:TextField = new TextField();
				var format:TextFormat = new TextFormat();
				format.font = "Visitor TT1 BRK";
				format.size = 10;
				tabMC.graphics.lineStyle(0, 0xffffff, 0.85);
				tabMC.graphics.beginFill(0xFFFFFF, 0.85);
				tabMC.graphics.moveTo((100 * (i) + 25), 15);
				tabMC.graphics.lineTo((100 * (i) + 25), 50);
				tabMC.graphics.lineTo((100 * (i+1)), 85);
				tabMC.graphics.lineTo((100 * (i +2)), 75);
				tabMC.graphics.lineTo((100 * (i + 2) + 25), 50);
				tabMC.graphics.lineTo((100 * (i + 2) + 25), 15);
				tabMC.graphics.lineTo((100 * (i) + 25), 15);
				tabMC.graphics.endFill();
				maskMC.graphics.beginFill(0, 0);
				maskMC.graphics.drawRect((100 * (i + 1)) - 50, 27, 200, 80);
				maskMC.graphics.endFill();
				bbMC.graphics.beginFill(0, 0);
				bbMC.graphics.drawRect((100 * (i + 1)), 50, 100, 35);
				bbMC.name = "btn" + i;
				cout("Button " + bbMC.name + " made.");
				tabHolder.addChild(bbMC);
				txtMC.text = String(i + 1);
				//txtMC.embedFonts = true;
				txtMC.setTextFormat(format);
				txtMC.x = 100 * (i + 1) + 50;
				txtMC.y = 60;
				tabMC.filters = new Array(dropShadow);
				//bbArr[bbMC.name] = bbMC;
				//tabArr[bbMC.name] = tabMC;
				bbArr.push(bbMC);
				tabArr.push(tabMC);
				tabHolder.addChildAt(tabMC, 0);
				tabHolder.addChild(maskMC);
				tabMC.addChild(txtMC);
				tabMC.mask = maskMC;
				tabIO[bbMC.name] = 0;
			}
		}
		
		private function addBackground(color:uint = 0xFFFFFF):void{
			//var background:Sprite = new Sprite();
			assets.newLayer("bg");
			assets.newAsset("back", new Sprite());
			assets.addAsset(assets.getLayer("bg"), assets.getAsset("back"));
			assets.getAsset("back").graphics.beginFill(color);
			assets.getAsset("back").graphics.drawRect(0, 0, stg_w, stg_h);
			assets.getAsset("back").graphics.endFill();
		}
		
		//~~~oOo~~~----------~~~oIo~~~----------~~~oOo~~~//
		////										   ////
		//////			  EVENT FUNCTIONS 			 //////
		////										   ////
		//~~~oOo~~~----------~~~oIo~~~----------~~~oOo~~~//
		
		public function update(e:Event):void {
			addBar(waver1, waver2);
			addSquares(isWaver1Growing, isWaver2Growing);
			for (var a:uint = 0; a < bbArr.length; a++) {
				if (bbArr[a].hitTestPoint(stg.mouseX, stg.mouseY, true)) {
					tabArr[a].y = 20;
				} else {
					tabArr[a].y = 0;
				}
			}
			if (waver1 >= 5) {
				isWaver1Growing = false;
			} else if (waver1 <= -5) {
				isWaver1Growing = true;
			}
			if (isWaver1Growing) {
				waver1 += 0.1;
			} else {
				waver1 -= 0.1;
			}
			if (waver2 >= 10) {
				isWaver2Growing = false;
			} else if (waver2 <= -10) {
				isWaver2Growing = true;
			}
			if (isWaver2Growing) {
				waver2 += 0.15;
			} else {
				waver2 -= 0.15;
			}
		}
		
		public function click(e:MouseEvent = null):void {
			var targName:String = e.target.name;
			if (targName.search("btn") != -1) {
				switch(targName) {
					case "btn0":
						//getImage("wide");
						getImage("CameraSunset");
						break;
					case "btn1":
						//getImage("tall");
						getImage("RainGod");
						break;
					case "btn2":
						//getImage("big");
						getImage("strangeminster");
						break;
					case "btn3":
						getImage("theuniversity")
						break;
					case "btn4":
						getImage("thiscitybleeds")
						break;
					case "btn5":
						getImage("weheardyousinging")
						break;
					case "btn6":
						getImage("hobohut")
						break;
				}
			}
		}
		
		private function getImage(name:String):void{
			for(var a:int = 0; a < assets.getLayer("frame").numChildren; a++){
				//assets.getLayer("frame").getChildAt(a).visible = false;
			}
			trace("");
			if(assets.getAsset(name)){
				cout("asset exists");
				//assets.getAsset(name).visible = true;
			} else { 
				cout("Creating Asset " + name);
				assets.loadAsset(name, ("../lib/"+ name + ".jpg"));
			}
			//assets.loadImage("frame", name);
		}
		
		public function assetSender(name:String):void{
			if(assets.getAsset(name)){
				cout("Received " + name + ".");
				assets.addAsset(assets.getLayer("frame"), assets.getAsset(name));
				resize(name);
			} else {
				cout("Object cannot be found");
			}
			//resize(name);
		}
		
		public function resize(name:String):void{
			cout("Resizing " + name + ".");
			var a:* = (assets.getAsset(name))
			var strictWidth:uint = 600;
			var strictHeight:uint = 300;
			
			thumbs.addThumb(a);
			
			a.scaleX = a.scaleY = 1;
			if(a.height >= a.width){
				if(a.height > strictHeight){
					var loaderH:Number = strictHeight/a.height; 
					a.scaleX = a.scaleY = loaderH;
				}
			} else if (a.height < a.width){
				if (a.width > strictWidth) {
					var loaderW:Number = strictWidth/a.width;
					a.scaleX = a.scaleY = loaderW;
				}
			}
			
			a.x = stg_w/2 - a.width/2;
			a.y = stg_h/2 - a.height/2 + 30;
			assets.newAsset(name + "border", new Sprite());
			assets.addAsset(a, assets.getAsset(name + "border"), 0);

			var border:Sprite = assets.getAsset(name+"border");
			border.graphics.lineStyle(0, 0, 0);
			border.graphics.beginFill(0xFFFFFF);
			border.graphics.drawRect(-borderSize / a.scaleX, -borderSize / a.scaleX, ((a.width) + (borderSize * 2))/a.scaleX, ((a.height) + (borderSize * 2))/ a.scaleX);
			
			a.filters = new Array(dropShadow);
			//border.x = stg_w/2 - assets.getAsset(name).width/2 - (borderSize);
			//border.y = stg_h/2 - assets.getAsset(name).height/2 - (borderSize) + 30;
		}
		
		//~~~oOo~~~----------~~~oIo~~~----------~~~oOo~~~//
		////										   ////
		//////			  	  HELPERS    			 //////
		////										   ////
		//~~~oOo~~~----------~~~oIo~~~----------~~~oOo~~~//
		
		private function debug():void{
			//super.debug();
		}
		
		private function cout(text:String = ""):void{
			caller.cout(getQualifiedClassName(this), text);
		}
	}
}

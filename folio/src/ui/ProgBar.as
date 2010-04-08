package ui
{
	import flash.display.*;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	
	public class ProgBar extends MovieClip
	{
		protected var g_parent:*;
		protected var dropShadow:DropShadowFilter;
		protected var cc:Sprite; //center circle
		protected var oc:Sprite; //outer circle
		protected var tb:TextField; //text box
		protected var dotLength:uint;
		protected var dotArray:Array;
		
		public function ProgBar(p_parent:*){
			g_parent = p_parent;
			g_parent.addChild(this);
			init();
		}
		
		protected function init():void{
			dotArray		= new Array();
			cc 				= new Sprite;
			oc 				= new Sprite;
			tb 				= new TextField();	
			setup();
		}
		
		protected function setup():void{
			addChild(cc);
			addChild(oc);
		}
		
		public function update(percent:Number):void{

		}
		
		public function get itemLength():uint{
			return dotLength;
		}
	}
}
package ui
{
	import flash.display.*;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;

	public class ProgAtom extends ProgBar
	{
		//private var dropShadow:DropShadowFilter;
		//private var dotLength:uint;
		
		public function ProgAtom(p_parent:*){
			super(p_parent);
			this.x = g_parent.stg_w/2;
			this.y = g_parent.stg_h/2;
		}
		
		override protected function init():void{
			super.init();
			dropShadow		= new DropShadowFilter();
				dropShadow.alpha = 0.3;
				dropShadow.distance = 3;
				dropShadow.blurX = dropShadow.blurY = 5;
			this.filters = new Array(dropShadow);
			dotLength		= 9;
			setup();
		}
		
		override protected function setup():void{
			addChild(cc);
			cc.graphics.lineStyle(2, 0, 0);
			cc.graphics.beginFill(0xFFFFFF);
			cc.graphics.drawCircle(0, 0, 8);
			cc.graphics.endFill();
			cc.addChild(tb);
			addChild(oc);
			
			for(var i:uint = 0; i < dotLength; i++){
				var xpos:Number = Math.cos(((2*Math.PI)/dotLength) * i - Math.PI/2);
				var ypos:Number = Math.sin(((2*Math.PI)/dotLength) * i - Math.PI/2);
				var item:Sprite = new Sprite();
				if(i == dotLength - 1){
					item.graphics.beginFill(0xFF3300);	
				} else {
					item.graphics.beginFill(0xFFFFFF);
				}
				item.graphics.drawCircle(xpos * 30, ypos * 30, 4);
				item.graphics.endFill();
				//item.alpha = (i)/dotLength;
				cc.addChild(item);
				dotArray.push(item);
			}
			
		}
		
		override public function update(percent:Number):void{
			this.rotation = 3.6 * percent;
			trace(percent);
		}
		
		override public function get itemLength():uint{
			return dotLength;
		}
	}
}
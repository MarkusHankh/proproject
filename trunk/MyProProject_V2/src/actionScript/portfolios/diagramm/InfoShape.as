package actionScript.portfolios.diagramm
{
	import mx.core.UIComponent;
	import mx.core.UITextField;  
	import mx.binding.utils.BindingUtils;  

	public class InfoShape extends UIComponent
	{
		var infos:Array = new Array();
		var index:Number = 1;
		var x1: Number;
		var y1: Number;	
		public function InfoShape(radius:Number=25,x:Number=0,y:Number=0,infos:Array=null)
		{
			
			this.width = 200;
			graphics.lineStyle(2,0x0066ff);
			graphics.beginFill(0xb7babc);
			graphics.drawRoundRect(x+30,y+30,250,300,20,20);
			graphics.endFill();	
			x1=x;
			y1=y;
			if(infos !=null){
				this.infos=infos;
			}
			
			var tfield:UITextField = new UITextField();
			tfield.x = x+90;
			tfield.y = y+30;
			this.addChild(tfield);
			
			for each (var info:SimpleInfoData in infos){
				info.x = x1+40;
				if(index == 1){
					info.y = y1+60;	
				} else {
					info.y = y1 + (25 * index);
				}
				this.addChild(info);
				index++;
			}
			
		}
		
		public function addInfo(info:SimpleInfoData) {
			infos.push(info);
			info.x = x1+40;
			//trace(index);
			index++;
			if(index == 1){
					info.y = y1+60;	
			} else {
				info.y = y1+(25 * index);
			}
			
			this.addChild(info);
		}

		
	}
}
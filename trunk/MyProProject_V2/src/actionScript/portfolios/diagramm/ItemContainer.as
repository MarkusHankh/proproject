package actionScript.portfolios.diagramm
{
	import mx.collections.ArrayCollection;
	import mx.core.Container;
	import mx.formatters.NumberFormatter;

	public class ItemContainer extends Container
	{
		var ring:DynamicRing2;
		var ring2:DynamicRing2;
		var days:Number;
		var formatter:NumberFormatter = new NumberFormatter();
		public var sd:ArrayCollection = new ArrayCollection();
		public var info:InfoShape;
		public var myId:int;
		public function ItemContainer(shape:Number=0,radius:Number=25,x:Number=0,y:Number=0,days:Number=0,heute:Number=0,progress1:Number=0,progress2:Number=0,info:InfoShape=null,line:Number=0,fill:Number=0,ring1color:Number=0,ring2color:Number=0)
		{
			if(y > 0){
				y = Math.abs(((y/100)*430)-430);	
			}else{
				y = 410;
			}
			if(x > 0){
				x =(x/100)*820;
			}else{
				x = 20;
			}
			
			trace(line+" "+fill+" "+ring1color+" "+ring2color);
			if(days >= 0) {
				var pr1:Number = ((progress1-heute) / days)*100;
			}else {
				pr1 =99;
			}
			
			if(pr1>=100){
				pr1 =100;
			}
			if(!(pr1>=0 && pr1 <=100)) {
				pr1=0;
			}
			
			radius = radius * 15;
			formatter.rounding = "down";
			formatter.precision = 0;
			// kleiner Ring
			ring = new DynamicRing2(radius,progress1,2,ring1color);
			//Großer Ring
			// hier progress2 0-100 
			ring2 = new DynamicRing2(radius+7,progress2,3,ring2color);
			this.info=info;
			switch (shape){
				case 0:
				var square = new DynamicSquare(radius,radius,1,line,fill);
				square.x = ring.x-(square.width/2);
				square.y = ring.y-(square.height/2);
				rawChildren.addChild(square);
				break;
				case 1:
				var tri = new DynamicTriangle(radius,1,line,fill);
				tri.x = ring.x+radius-(tri.width/1.5);
				tri.y = ring.y+radius-(tri.height);
				rawChildren.addChild(tri);
				break;
				case 2:
				var egg = new DynamicEgg(radius,1,line,fill);
				egg.x = ring.x+radius-(egg.width/1.5);
				egg.y = ring.y+radius-(egg.height);
				rawChildren.addChild(egg);
				break;
			}
			this.x=x;
			this.y=y;
			rawChildren.addChild(ring);
			rawChildren.addChild(ring2);
			
		}
		
		public function put(str1,str2):void {
			sd.addItem(new SimpleInfoData(str1,str2));
		}
		
		public function goFrwd(progress){
			ring.reFill(progress);
		}
		public function getXValue():String {
			return formatter.format((x/820)*100);
		}
		public function getYValue():String {
			return formatter.format(Math.abs(((y/430)*100)-100));
		}
		
	}
}
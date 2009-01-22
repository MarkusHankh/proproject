package Shapes
{
	import flash.display.*;
	
	public class DynamicRing extends Shape
	{
		var progress:Number = 0;
		var rad:Number = 30;
		var thickness:Number=2;
		var color:Number=0x0005ff;
		public function DynamicRing(radius:Number, progress:Number=0, thickness:Number=2,color:Number=0x0005ff)
		{
			this.rad=radius;
			this.progress=progress;
			this.thickness = thickness;
			this.color = color;
			myCircle(graphics,0, 0, radius, 100);
			rotation=-90;
		}
		

		private function myCircle(mc:Graphics, centerX:Number, centerY:Number, radius:Number,sides:Number):void{
			mc.lineStyle(thickness,color);
			mc.moveTo(centerX + radius,  centerY);
			for(var i:Number=0; i<=sides; i++){
				var pointRatio:Number = i/sides;
				var xSteps:Number = magicTrigFunctionX(pointRatio);
				var ySteps:Number = magicTrigFunctionY(pointRatio);
				var pointX:Number = centerX + xSteps * radius;
				var pointY:Number = centerY + ySteps * radius;
				mc.lineTo(pointX, pointY);
				if(i >= progress){
					break;
				}
			}
	
		}
		
		public function reFill(progress:Number):void{
			myCircle(graphics,0, 0, rad, 100);
		}
		
		function magicTrigFunctionX (pointRatio){
			return Math.cos(pointRatio*2*Math.PI);
		}
		function magicTrigFunctionY (pointRatio){
			return Math.sin(pointRatio*2*Math.PI);
		}

		
		
	}
}
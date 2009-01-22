package actionScript.portfolios.diagramm
{
	import actionScript.portfolios.diagramm.animation.RingAnimation;
	
	import flash.display.*;
	public class DynamicRing2 extends Shape
	{
		public var progress:Number = 0;
		var rad:Number = 30;
		var oldX:Number = 0;
		var oldY:Number = 0;
		public var ra:RingAnimation = new RingAnimation(this);
		
		public function DynamicRing2(radius:Number,progress:Number, thickness:Number=2,color:Number=0x0005ff)
		{
			this.progress=progress;
			this.rad=radius;
			this.oldX = radius;
			rotation=-90;
			doInit();
		}
		
		function doInit():void{
			ra.setAngle(progress);
			ra.duration = 1000;
			ra.play([this]);
		}

		private function myCircle(mc:Graphics, radius:Number,sides:Number,i:Number):void{
			var centerX = 0; 
			var centerY = 0; 
			mc.lineStyle(2,0x0005ff);
			mc.moveTo(oldX,  oldY);
			var pointRatio:Number = i/sides;
			var xSteps:Number = magicTrigFunctionX(pointRatio);
			var ySteps:Number = magicTrigFunctionY(pointRatio);
			var pointX:Number = centerX + xSteps * radius;
			var pointY:Number = centerY + ySteps * radius;
			mc.lineTo(pointX, pointY);
			oldX = pointX;
			oldY = pointY;
		}
		
		
		public function reFill(progress:Number):void{
			myCircle(graphics,rad,100, progress);
		}
		
		function magicTrigFunctionX (pointRatio){
			return Math.cos(pointRatio*2*Math.PI);
		}
		function magicTrigFunctionY (pointRatio){
			return Math.sin(pointRatio*2*Math.PI);
		}

		
		
	}
}
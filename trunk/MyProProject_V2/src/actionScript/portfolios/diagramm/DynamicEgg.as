package actionScript.portfolios.diagramm
{
	import flash.display.*;
	
	public class DynamicEgg extends Shape
	{
		public function DynamicEgg(width, border:Number=1,fill:Number=0xcccccc,line:Number=0xff000f)
		{
			graphics.lineStyle(border,line);
			graphics.beginFill(fill);
			graphics.drawCircle(0,0,width/2);
			graphics.endFill();
		}

	}
}
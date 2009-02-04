package actionScript.portfolios.diagramm
{
	import flash.display.*;
	
	public class DynamicSquare extends Shape
	{
		public function DynamicSquare(width, height,border:Number=1,fill:Number=0xcccccc,line:Number=0xff000f)
		{
			graphics.lineStyle(border,line);
			graphics.beginFill(fill);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}

	}
}
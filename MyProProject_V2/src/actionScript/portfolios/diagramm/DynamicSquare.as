package actionScript.portfolios.diagramm
{
	import flash.display.*;
	
	public class DynamicSquare extends Shape
	{
		public function DynamicSquare(width, height,border:Number=1)
		{
			graphics.lineStyle(border,0xff000f);
			graphics.beginFill(0xcccccc);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}

	}
}
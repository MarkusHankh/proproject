package actionScript.portfolios.diagramm
{
	import flash.display.Shape;

	public class DynamicTriangle extends Shape
	{
		var lineLenght:Number = 20;
		public function DynamicTriangle(lineLenght:Number = 20,border:Number=1)
		{
			this.lineLenght=lineLenght;
			lineLenght=lineLenght/2;
			graphics.lineStyle(border,0xff000f);
			graphics.beginFill(0x0f0f0f);
			graphics.lineTo(lineLenght/2, lineLenght);
			graphics.lineTo((-lineLenght-lineLenght/2), lineLenght);
			graphics.lineTo(-lineLenght/2, -(lineLenght));
			graphics.endFill();
		}
		
	}
}
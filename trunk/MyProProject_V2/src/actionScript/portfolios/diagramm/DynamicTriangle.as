package actionScript.portfolios.diagramm
{
	import flash.display.Shape;

	public class DynamicTriangle extends Shape
	{
		var lineLenght:Number = 20;
		public function DynamicTriangle(lineLenght:Number = 20,border:Number=1,fill:Number=0xcccccc,line:Number=0xff000f)
		{
			this.lineLenght=lineLenght;
			lineLenght=lineLenght/2;
			graphics.lineStyle(border,line);
			graphics.beginFill(fill);
			graphics.lineTo(lineLenght/2, lineLenght);
			graphics.lineTo((-lineLenght-lineLenght/2), lineLenght);
			graphics.lineTo(-lineLenght/2, -(lineLenght));
			graphics.endFill();
		}
		
	}
}
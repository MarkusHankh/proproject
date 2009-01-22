package actionScript.portfolios.diagramm
{
	import mx.core.UITextField;
	
	public class SimpleInfoData extends UITextField
	{
		var text1:UITextField = new UITextField();
		var text2:UITextField = new UITextField();
		public function SimpleInfoData(s1:String,s2:String)
		{
			text1.text = s1;
			text2.text = s2;
			this.width = 200;
			this.text = text1.text + ": " +text2.text;
		}

	}
}
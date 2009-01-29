// ActionScript file
import mx.events.DataGridEvent;

private function initGridAttribut():void
{
	dgSpezifischeAttribute = new ArrayCollection();
	dgSpezifischeAttribute.addItem({1:"Attributname...", 3:"0"});
	dgSpezifischeAttribute.addItem({title: ADD_TASK});
}

private static const ADD_TASK:String = "Click to Add Task";

private function checkEdit(e:DataGridEvent):void
{
	if(e.rowIndex == dgSpezifischeAttribute.length - 1 && e.columnIndex != 0)
	e.preventDefault();
}
      
private function editEnd(e:DataGridEvent):void
{
	if(e.rowIndex == dgSpezifischeAttribute.length - 1)
	{
		var txtIn:TextInput = TextInput(e.currentTarget.itemEditorInstance);
		var dt:Object = e.itemRenderer.data;

		if(txtIn.text != ADD_TASK){
			dgSpezifischeAttribute.addItemAt(({1:txtIn.text, 3:"..."}), e.rowIndex);
		}
		
	gridPortfolioAttributeNeu.destroyItemEditor();
          
	e.preventDefault();
	}
}

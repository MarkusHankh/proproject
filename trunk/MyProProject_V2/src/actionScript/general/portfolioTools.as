// ActionScript file
private function checkEdit(e:DataGridEvent):void
{
	if(e.rowIndex == dgList.length - 1 && e.columnIndex != 0)
	e.preventDefault();
}
      
private function editEnd(e:DataGridEvent):void
{
	if(e.rowIndex == dgList.length - 1)
	{
		var txtIn:TextInput = TextInput(e.currentTarget.itemEditorInstance);
		var dt:Object = e.itemRenderer.data;

		if(txtIn.text != ADD_TASK){
			dgList.addItemAt(new Attribute(txtIn.text, "", "", ""), e.rowIndex);
		}
		
	dgAttributeAnlegen.destroyItemEditor();
          
	e.preventDefault();
	}
}
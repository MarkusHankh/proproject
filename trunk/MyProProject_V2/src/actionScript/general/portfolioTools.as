// ActionScript file
import mx.collections.ArrayCollection;
import mx.events.DataGridEvent;

private function initGridAttribut():void
{
	dgSpezifischeAttribute = new ArrayCollection();
	dgSpezifischeAttribute.addItem({2: ADD_TASK});
}


private static const ADD_TASK:String = "Neues Attribut hinzufügen!";

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
			dgSpezifischeAttribute.addItemAt(({1:txtIn.text, 3:"Tooltip"}), e.rowIndex);
		}
		
	gridPortfolioAttributeNeu.destroyItemEditor();
          
	e.preventDefault();
	}
}

private function checkEdit2(e:DataGridEvent):void
{
	if(e.rowIndex == dpPortfolioAttributes.length - 1 && e.columnIndex != 0)
	e.preventDefault();
}
      
private function editEnd2(e:DataGridEvent):void
{
	if(e.rowIndex == dpPortfolioAttributes.length - 1)
	{
		var txtIn:TextInput = TextInput(e.currentTarget.itemEditorInstance);
		var dt:Object = e.itemRenderer.data;

		if(txtIn.text != ADD_TASK){
			dpPortfolioAttributes.addItemAt(({1:txtIn.text, 3:"Tooltip"}), e.rowIndex);
		}
		
	gridPortfolioAttributeEdit.destroyItemEditor();
          
	e.preventDefault();
	}
}



public function editPortfolio():void
{
	var portfolioName:String = portfolioSelector.text;
	var portfolioID:int;
	if (dpPortfolio!=null)
	{
		for (var i:int=0; i<dpPortfolioSelector.length; i++)
		{
			if (dpPortfolio.length > 0 && dpPortfolio[i][1]==portfolioName)
			{
				portfolioID=dpPortfolio[i][0];
			}
		}
	}
	else
	{
		Alert.show("dpPortfolio ist null!");
	}
	
	threepv_service.getPortfolioValues.send(portfolioID);
}

public function deletePortfolio():void
{
	var portfolioName:String = portfolioSelector.text;
	var portfolioID:int;
	if (dpPortfolio!=null)
	{
		for (var i:int=0; i<dpPortfolioSelector.length; i++)
		{
			if (dpPortfolio.length > 0 && dpPortfolio[i][1]==portfolioName)
			{
				portfolioID=dpPortfolio[i][0];
			}
		}
	}
	else
	{
		Alert.show("dpPortfolio ist null!");
	}
	
	threepv_service.deletePortfolio.send(portfolioID);
	
	
}

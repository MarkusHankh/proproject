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

public function getCurrentPortfolioID():int
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
	
	return portfolioID;
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
	var portfolioID:int = this.getCurrentPortfolioID();
	threepv_service.getPortfolioValues.send(portfolioID);
}

public function deletePortfolio():void
{
	var portfolioID:int = this.getCurrentPortfolioID();
	
	threepv_service.deletePortfolio.send(portfolioID);
	refreshAll(portfolioSelector.text);
	changeContent('diagramContent');
}

public function resetNewPortfolio():void
{
	portfolionameNeu.text='';
	portfolioBeschreibungNeu.text='';
	nameXAchseNeu.text='';
	nameYAchseNeu.text='';
	kleinsterXWertNeu.value=0;
	groessterXWertNeu.value=0;
	kleinsterYWertNeu.value=0;
	groessterYWertNeu.value=0;
	initGridAttribut();
	init();
}

public function resetEditPortfolio():void
{
	editPortfolio();
	init();
}

public function preparePortfolioExport():void
{
	var userID:int = session.data.userID;
	var companyID:int =  session.data.userCompany;
	threepv_service.newPortfolio.send(portfolionameNeu.text, kleinsterXWertNeu.value, groessterXWertNeu.value, kleinsterYWertNeu.value, groessterYWertNeu.value, nameXAchseNeu.text, nameYAchseNeu.text, portfolioBeschreibungNeu.text, companyID);
	
	portfolionameNeu.text="";
	kleinsterXWertNeu.value=0;
	groessterXWertNeu.value=0;
	kleinsterYWertNeu.value=0;
	groessterYWertNeu.value=0;
	nameXAchseNeu.text="";
	nameYAchseNeu.text="";
	portfolioBeschreibungNeu.text="";
}

public function preparePortfolioEditExport(attributesCount:int):void
{
	var portfolioID:int=this.getCurrentPortfolioID();
	var companyID:int =  session.data.userCompany;
	
	for (var i:int=0; i<dpPortfolioAttributes.length-1; i++)
	{
		if(i<attributesCountFromDB)	
		{
			threepv_service.updateAttribute.send(portfolioID, dpPortfolioAttributes[i][0], dpPortfolioAttributes[i][1], dpPortfolioAttributes[i][3]);
		}
		else
		{
			threepv_service.setAttributes.send(portfolioID, dpPortfolioAttributes[i][1], '', dpPortfolioAttributes[i][3]);
		}
	}

	threepv_service.editPortfolio.send(portfolioID, portfolionameEdit.text, kleinsterXWertEdit.value, groessterXWertEdit.value, kleinsterYWertEdit.value, groessterYWertEdit.value, nameXAchseEdit.text, nameYAchseEdit.text, portfolioBeschreibungEdit.text, companyID);
		
	portfolionameEdit.text="";
	kleinsterXWertEdit.value=0;
	groessterXWertEdit.value=0;
	kleinsterYWertEdit.value=0;
	groessterYWertEdit.value=0;
	nameXAchseEdit.text="";
	nameYAchseEdit.text="";
	portfolioBeschreibungEdit.text="";
	
	refreshAll(portfolioSelector.text);
	changeContent('diagramContent');
}

public function deletePortfolioAttribute():void
{
	var portfolioID:int=this.getCurrentPortfolioID();
	var attributeID:int;
	for (var i:int=0; i < dpPortfolioAttributes.length; i++)
	{
		if (dpPortfolioAttributes[i][1]==gridPortfolioAttributeEdit.selectedItem[1])
		{
			//Alert.show('dpPortfolioAttributes[i][1]==gridPortfolioAttributeEdit.selectedItem[1]');
			attributeID=dpPortfolioAttributes[i][0];
		}
	}
	
	threepv_service.deleteAttribute.send(portfolioID, attributeID);
	refreshAll(portfolioSelector.text);
}

import mx.controls.Alert;
public function refreshAll(portfolio:String):void{
	var portfolioID:int;
		if (dpPortfolio!=null)
		{
			for (var i:int=0; i<dpPortfolioSelector.length; i++)
			{
				if (dpPortfolio[i][1]==portfolio)
				{
					portfolioID=dpPortfolio[i][0];
					lblYAchse.text = dpPortfolio[i][7];
					lblXAchse.text = dpPortfolio[i][6];
				}
			}
		}
		else
		{
			Alert.show("dpPortfolio ist null!");
		}
		threepv_service.getAttributes.send(portfolioID);
		threepv_service.getMyProjects.send(session.data.userID, portfolioID);
		//TODO Diagramm neu laden
		dia.removeAllChildren();
}

public function deleteProject():void
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
	threepv_service.deleteProject.send(gridProjectListView.selectedItem[0]);
	threepv_service.getMyProjects.send(session.data.userID, portfolioID);
	
	changeContent('listContent');
}

public function resetNewProject():void
{
	projektnameNeu.text='';
	beschreibungNeu.text='';
	startdatumNeu.text='';
	enddatumNeu.text='';
	formNeu.text="Kreis";
	formgroesseNeu.text="Klein";
	xAchseNeu.value=0.0;
	yAchseNeu.value=0.0;
	fuellfarbeNeu.selectedColor = 000000;
	rahmenfarbeNeu.selectedColor = 000000;
	ringfarbeInnenNeu.selectedColor = 000000;
	ringfarbeAussenNeu.selectedColor = 000000;
	
	gridTeamNeu.dataProvider = new ArrayCollection();
	init();
	
}

public function resetEditProject():void
{
	
	getProjectEdit(0);
	gridTeamEdit.dataProvider = new ArrayCollection();
	init();
}
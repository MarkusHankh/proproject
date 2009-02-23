import mx.collections.ArrayCollection;
import mx.utils.ArrayUtil;

[Bindable]
var CurrentProjectID:int;

[Bindable]
public var teamEditBeforUpdate:ArrayCollection;

public function refreshAll(portfolio:String):void
{
	var portfolioID:int=getCurrentPortfolioID();
	threepv_service.getAttributes.send(portfolioID);
	threepv_service.getMyProjects.send(session.data.userID, portfolioID);
	//TODO Diagramm neu laden
	dia.removeAllChildren();
	gridTeamNeu.dataProvider = new ArrayCollection();
	dgSpezifischeAttribute = new ArrayCollection();
	initGridAttribut();
}

public function deleteProject():void
{
	var portfolioID:int=getCurrentPortfolioID();
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

public function prepareProjectExport():void
{
	var portfolioID:int=getCurrentPortfolioID();
	var formGroesseInt:int;
	switch(formgroesseNeu.text)
	{
		case 'Klein':
			formGroesseInt = 1;
			break;
		case 'Mittel':
			formGroesseInt = 2;
			break;
		case 'Groß':
			formGroesseInt = 3;
			break;
	}
	
	var projektLeader:int = session.data.userID;
	threepv_service.newProject.send(projektLeader, portfolioID, projektnameNeu.text, startdatumNeu.text, enddatumNeu.text, formNeu.text, formGroesseInt, xAchseNeu.value, yAchseNeu.value, fuellfarbeNeu.selectedColor.toString(16), rahmenfarbeNeu.selectedColor.toString(16), beschreibungNeu.text, ringfarbeInnenNeu.selectedColor.toString(16), ringfarbeAussenNeu.selectedColor.toString(16));
	projektnameNeu.text="";
	startdatumNeu.text="";
	enddatumNeu.text="";
	formNeu.text="Kreis";
	formgroesseNeu.text="Klein";
	xAchseNeu.value=0.00;
	yAchseNeu.value=0.00;
	beschreibungNeu.text="";
	fuellfarbeNeu.selectedColor = 000000;
	rahmenfarbeNeu.selectedColor = 000000;
	ringfarbeInnenNeu.selectedColor = 000000;
	ringfarbeAussenNeu.selectedColor = 000000;
}

public function prepareProjectEditExport():void
{
	var projectID:int=0;
	if (gridProjectListView.selectedItem!=null)
	{
		projectID=gridProjectListView.selectedItem[0];
	}
	else
	{
		projectID=CurrentProjectID;
	}
	
	var portfolioID:int=getCurrentPortfolioID();
	
	var formGroesseInt:int;
	switch(formgroesseEdit.text)
	{
		case 'Klein':
			formGroesseInt = 1;
			break;
		case 'Mittel':
			formGroesseInt = 2;
			break;
		case 'Groß':
			formGroesseInt = 3;
			break;
	}

	var projektLeader:int = session.data.userID;
	threepv_service.editProject.send(projectID, projektnameEdit.text, startdatumEdit.text, enddatumEdit.text, formEdit.text, formGroesseInt, xAchseEdit.value, yAchseEdit.value, fuellfarbeEdit.selectedColor.toString(16), rahmenfarbeEdit.selectedColor.toString(16), beschreibungEdit.text, ringfarbeInnenEdit.selectedColor.toString(16), ringfarbeAussenEdit.selectedColor.toString(16));
	
	/*
	 *Benutzerspezifische Attribute erzeugen und bearbeiten
	 *
	 */
	var attributid:int=0;
	var attributwert:String='';
	for(var i:int = 0; i < gridAttributeEdit.dataProvider.length-1; i++)
 	{
 		try
 		{
   			attributid = gridAttributeEdit.dataProvider[i][0].valueOf();
   			//dpPortfolioAttributes
   			if(gridAttributeEdit.dataProvider[i][5])
   			{
   				//attributwert = gridAttributeEdit.dataProvider[i][5];
  				threepv_service.setProjectAttributes.send(projectID, attributid, gridAttributeEdit.dataProvider[i][5]);
  				
   			}
   			else
   			{
   				continue;
   			}
  		}
  		catch(e:Error)
  		{
   			//Do Nothing :)
  		}
 	}
	
	/*
	 *Projektmitglieder hinzufügen und löschen
	 *
	 */
	 
	//if(gridTeamEdit.dataProvider.length>projectTeamCountFromDB) 
	
	
	for (var j:int=0; j<teamEditBeforUpdate.length; j++)
	{
		threepv_service.deleteBenutzerProjekt.send(teamEditBeforUpdate[j][0], projectID);
	}
	for (var i:int=0; i<gridTeamEdit.dataProvider.length; i++)
	{
		threepv_service.setBenutzerProjekt.send(gridTeamEdit.dataProvider[i][0], projectID);
	}
	
	refreshAll(portfolioSelector.text);
	changeContent('diagramContent');
}

public function getProjectEdit(id:int):void
{
	
	if(id != 0)
	{
		CurrentProjectID = id;
	}
	else
	{
		CurrentProjectID=gridProjectListView.selectedItem[0];
	}
	var portfolioID:int=getCurrentPortfolioID();
	teamEditBeforUpdate=new ArrayCollection();
	threepv_service.getProjectValues.send(CurrentProjectID);
	threepv_service.getProjectAttributes.send(CurrentProjectID);
	threepv_service.getProjectUser.send(CurrentProjectID);
}


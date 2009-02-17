
	import mx.controls.Alert;
	
	public function prepareProjectExport():void{
	var portfolioId:int;
	var portfolioName:String = portfolioSelector.text;
	for(var i:int = 0; i < dpPortfolio.length; i++){
		if(portfolioName == dpPortfolio[i][1]){
			portfolioId = dpPortfolio[i][0];
		}
	}
	var formGroesseInt:int;
	switch(formgroesseNeu.text){
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
	//Alert.show(gridTeamNeu.dataProvider[0][0]);
	threepv_service.newProject.send(projektLeader, portfolioId, projektnameNeu.text, startdatumNeu.text, enddatumNeu.text, formNeu.text, formGroesseInt, xAchseNeu.value, yAchseNeu.value, fuellfarbeNeu.selectedColor.toString(16), rahmenfarbeNeu.selectedColor.toString(16), beschreibungNeu.text, ringfarbeInnenNeu.selectedColor.toString(16), ringfarbeAussenNeu.selectedColor.toString(16));
	projektnameNeu.text="";
	startdatumNeu.text="";
	enddatumNeu.text="";
	formNeu.text="Kreis";
	formgroesseNeu.text="Klein";
	xAchseNeu.value=0.00;
	yAchseNeu.value=0.00;
	beschreibungNeu.text="";
	//fuellfarbeNeu.;
	//rahmenfarbeNeu.;
	//ringfarbeInnenNeu.;
	//ringfarbeAussenNeu.;
}

public function prepareProjectEditExport():void
{
	var projectID:int=gridProjectListView.selectedItem[0];

	var portfolioId:int;
	var portfolioName:String = portfolioSelector.text;
	for(var i:int = 0; i < dpPortfolio.length; i++){
		if(portfolioName == dpPortfolio[i][1]){
			portfolioId = dpPortfolio[i][0];
		}
	}
	var formGroesseInt:int;
	switch(formgroesseEdit.text){
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
	
	threepv_service.getProjectValues.send(projectID);
	
	
	var projektLeader:int = session.data.userID;
	
	
	threepv_service.editProject.send(projectID, projektnameEdit.text, startdatumEdit.text, enddatumEdit.text, formEdit.text, formGroesseInt, xAchseEdit.value, yAchseEdit.value, fuellfarbeEdit.selectedColor.toString(16), rahmenfarbeEdit.selectedColor.toString(16), beschreibungEdit.text, ringfarbeInnenEdit.selectedColor.toString(16), ringfarbeAussenEdit.selectedColor.toString(16));
	
	Alert.show("Änderungen wurde gespeichert \nListenansicht muss noch refresht werden!!!");
	
	threepv_service.getProjectValues.send(projectID);

}

public function getProjectEdit():void{
	var projectID:int=gridProjectListView.selectedItem[0];

	var portfolioId:int;
	var portfolioName:String = portfolioSelector.text;
	for(var i:int = 0; i < dpPortfolio.length; i++){
		if(portfolioName == dpPortfolio[i][1]){
			portfolioId = dpPortfolio[i][0];
		}
	}
	var formGroesseInt:int;
	switch(formgroesseEdit.text){
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
	
	threepv_service.getProjectValues.send(projectID);
	threepv_service.getProjectAttributes.send(projectID);
}


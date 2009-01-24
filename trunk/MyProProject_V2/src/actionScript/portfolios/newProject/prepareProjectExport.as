
	import mx.controls.Alert;
	public function prepareProjectExport():void{
	var portfolioId:int;
	var portfolioName:String = portfolioSelector.text;
	for(var i:int = 0; i < dpPortfolio.length; i++){
		if(portfolioName == dpPortfolio[i][1]){
			portfolioId = dpPortfolio[i][0];
		}
	}
	var projektLeader:int = 1;
	var userArray:Array = ArrayUtil.toArray(gridTeamNeu.dataProvider);
	var attributArray:Array = ArrayUtil.toArray(gridAttributeNeu.dataProvider);
	Alert.show(attributArray.toString());
	//threepv_service.newProject.send();
}
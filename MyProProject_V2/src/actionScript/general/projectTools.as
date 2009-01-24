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
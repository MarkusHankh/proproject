public function editProject():void
{
	
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
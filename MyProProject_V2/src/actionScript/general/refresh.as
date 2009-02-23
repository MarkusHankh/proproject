import mx.collections.ArrayCollection;
public function refresh():void{
	dia.removeAllChildren();
	//threepv_service.getMyPortfolios.send(session.data.userID);
	threepv_service.getMyProjects.send(session.data.userID, getCurrentPortfolioID());
	threepv_service.getAttributes.send(getCurrentPortfolioID());
	threepv_service.getMyUsers.send(session.data.userID);
	threepv_service.getUser.send(session.data.userCompany);
	gridTeamNeu.dataProvider = new ArrayCollection();
}

public function refreshPortfolioOnly():void{
	threepv_service.getMyPortfolios.send(session.data.userID);
}
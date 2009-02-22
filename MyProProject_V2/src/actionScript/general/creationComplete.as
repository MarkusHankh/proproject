
	import mx.controls.Alert;

	public function init():void{
	var session:SharedObject = SharedObject.getLocal("3PvSession");
	if(session.data.userID != undefined){
		threepv_service.getMyPortfolios.send(session.data.userID);
		//Hier die Settings des eingeloggten Benutzers aufrufen
		//threepv_service.getMySettings(session.data.userID);
		threepv_service.getUser.send(session.data.userCompany);
		threepv_service.getDefaultAttributesVisualisations();
		initGridAttribut();
	}else{
		Alert.show('Fehler beim erstellen der Session!');
	}
}
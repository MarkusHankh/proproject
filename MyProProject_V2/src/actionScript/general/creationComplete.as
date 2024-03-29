	import mx.controls.Alert;
	import mx.core.Application;

public function init():void{
	var session:SharedObject = SharedObject.getLocal("3PvSession");
	if(session.data.userID != undefined){
		threepv_service.getMySettings.send(session.data.userID);
		threepv_service.getAllMySettings.send(session.data.userID);
		threepv_service.getMyPortfolios.send(session.data.userID);
		threepv_service.getUser.send(session.data.userCompany);
		threepv_service.getDefaultAttributesVisualisations();
		initGridAttribut();
	}else{
		Alert.show('Fehler beim erstellen der Session!');
	}
}

public function standardSettings():void{
	//Der Benutzer mit der ID 1 ist ein Dummy-Benutzer...
	threepv_service.getMySettings.send('1');
}
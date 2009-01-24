
	import mx.controls.Alert;
	public function init():void{
	var session:SharedObject = SharedObject.getLocal("3PvSession");
	if(session.data.userID != undefined){
		threepv_service.getMyPortfolios.send(session.data.userID);
		threepv_service.getUser.send(session.data.userCompany);
	}else{
		Alert.show('Fehler beim erstellen der Session!');
	}
}
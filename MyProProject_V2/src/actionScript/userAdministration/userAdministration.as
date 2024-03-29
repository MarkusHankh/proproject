
	import mx.controls.Alert;
	public function createUserAccount(vorname:String, nachname:String, benutzername:String, email:String, passwort:String, passwort2:String):void{
	if(vorname != '' && nachname != '' && benutzername != '' && email != '' && passwort != '' && passwort2 != '' && passwort == passwort2){
		var companyID:String = session.data.userCompany;
		threepv_service.addUser.send(vorname, nachname, benutzername, email, passwort, companyID);
	}else{
		if(vorname == ''){
			lblVornameNeu.setStyle('color', '#ff0000');
		}else{
			lblVornameNeu.setStyle('color', '#cccccc');
		}
		if(nachname == ''){
			lblNachnameNeu.setStyle('color', '#ff0000');
		}else{
			lblNachnameNeu.setStyle('color', '#cccccc');
		}
		if(benutzername == ''){
			lblBenutzernameNeu.setStyle('color', '#ff0000');
		}else{
			lblBenutzernameNeu.setStyle('color', '#cccccc');
		}
		if(email == ''){
			lblEmailNeu.setStyle('color', '#ff0000');
		}else{
			lblEmailNeu.setStyle('color', '#cccccc');
		}
		if(passwort == '' || passwort2 == '' || passwort != passwort2){
			lblPasswortNeu.setStyle('color', '#ff0000');
			lblPasswort2Neu.setStyle('color', '#ff0000');
		}else{
			lblPasswortNeu.setStyle('color', '#cccccc');
			lblPasswort2Neu.setStyle('color', '#cccccc');
		}
	}
}

public function clearNewUserFields():void{
	vornameNeu.text = '';
	nachnameNeu.text = '';
	benutzernameNeu.text = '';
	emailNeu.text = '';
	passwortNeu.text = '';
	passwort2Neu.text = '';
	lblVornameNeu.setStyle('color', '#cccccc');
	lblNachnameNeu.setStyle('color', '#cccccc');
	lblBenutzernameNeu.setStyle('color', '#cccccc');
	lblEmailNeu.setStyle('color', '#cccccc');
	lblPasswortNeu.setStyle('color', '#cccccc');
	lblPasswort2Neu.setStyle('color', '#cccccc');
	
}

public function deleteUser():void{
	threepv_service.deleteUser.send(gridShowAllUsers.selectedItem[0]);
	threepv_service.getUser.send(session.data.userCompany);
	changeContent('alleBenutzerContent');
}

public function editUser(vorname:String, nachname:String, benutzername:String, email:String, passwort:String, passwort2:String):void{
	if(vorname != '' && nachname != '' && benutzername != '' && email != '' && passwort != '' && passwort2 != '' && passwort == passwort2){
		threepv_service.editUser.send(gridShowAllUsers.selectedItem[0].toString(), vorname, nachname, email, benutzername, passwort);
	}else{
		Alert.show('Sie haben die Pflichtfelder nicht korrekt ausgefüllt');
	}
	
}

public function setBenutzerEditFields():void{
	vornameEdit.text = gridShowAllUsers.selectedItem[1].toString();
	nachnameEdit.text = gridShowAllUsers.selectedItem[2].toString();
	benutzernameEdit.text = gridShowAllUsers.selectedItem[6].toString();
	emailEdit.text = gridShowAllUsers.selectedItem[3].toString();
	passwortEdit.text = '';
	passwort2Edit.text = '';
}
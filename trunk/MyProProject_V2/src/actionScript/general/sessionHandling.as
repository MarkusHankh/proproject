import flash.net.SharedObject;
import flash.net.URLRequest;

public function userLogin(user:String, passwort:String):void{
	if(user != '' && passwort != ''){
		threepv_service.userLogin.send(user, passwort);
	}else{
		loginFehler.text = 'Bitte füllen Sie die Felder aus!';
	}
}

public function userLoginAbort():void{
	benutzernameLogin.text = '';
	passwortLogin.text = '';
	loginFehler.text = '';
}

public function userLogout():void{
	var session:SharedObject = SharedObject.getLocal("3PvSession");
	session.clear();
	dia.removeAllChildren();
	var myUrl:URLRequest = new URLRequest('MyProProject.html');
    navigateToURL(myUrl, '_parent');
}

public function register(organisation:String, vorname:String, nachname:String, benutzername:String, email:String, passwort:String, passwort2:String):void{
	if(organisation != '' && vorname != '' && nachname != '' && benutzername != '' && email != '' && passwort != '' && passwort2 != '' && passwort == passwort2){
		threepv_service.register.send(organisation, vorname, nachname, email, benutzername, passwort);
	}else{
		if(organisation == ''){
			lblOrganisationRegister.setStyle('color', '#ff0000');
		}else{
			lblOrganisationRegister.setStyle('color', '#000000');
		}
		if(vorname == ''){
			lblVornameRegister.setStyle('color', '#ff0000');
		}else{
			lblVornameRegister.setStyle('color', '#000000');
		}
		if(nachname == ''){
			lblNachnameRegister.setStyle('color', '#ff0000');
		}else{
			lblNachnameRegister.setStyle('color', '#000000');
		}
		if(benutzername == ''){
			lblBenutzernameRegister.setStyle('color', '#ff0000');
		}else{
			lblBenutzernameRegister.setStyle('color', '#000000');
		}
		if(email == ''){
			lblEmailRegister.setStyle('color', '#ff0000');
		}else{
			lblEmailRegister.setStyle('color', '#000000');
		}
		if(passwort == '' || passwort2 == '' || passwort != passwort2){
			lblPasswortRegister.setStyle('color', '#ff0000');
			lblPasswort2Register.setStyle('color', '#ff0000');
		}else{
			lblPasswortRegister.setStyle('color', '#000000');
			lblPasswortRegister.setStyle('color', '#000000');
		}
	}
}
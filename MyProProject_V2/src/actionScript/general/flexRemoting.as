import flash.net.SharedObject;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.rpc.events.ResultEvent;
import mx.utils.ArrayUtil;

[Bindable]
public var session:SharedObject = SharedObject.getLocal("3PvSession");

//Variablen vom Backend
[Bindable]
private var dpUser:ArrayCollection;

[Bindable]
private var dpPortfolioSelector:ArrayCollection;

[Bindable]
private var dpPortfolio:ArrayCollection;

[Bindable]
private var dpPortfolioAttributes:ArrayCollection;

[Bindable]
private var dpMyProjects:ArrayCollection;

[Bindable]
private var dpUserSession:ArrayCollection;

[Bindable]
private var arrayAldi:ArrayCollection;

//Result Events - FlexRemoting
public function registerResult(event:ResultEvent):void{
	if(event.result){
		var user:String = event.result[0];
		var pass:String = event.result[1];
		threepv_service.userLogin.send(user, pass);
	}else{
		Alert.show('Registrierung konnte nicht durchgeführt werden!');
	}
	
}

public function userLoginResult(event:ResultEvent):void{
	if(event.result){
		dpUserSession = new ArrayCollection(ArrayUtil.toArray(event.result));
		session.data.userID = dpUserSession[0][0];
		session.data.userPrename = dpUserSession[0][1];
		session.data.userLastname = dpUserSession[0][2]
		session.data.userMail = dpUserSession[0][3];
		session.data.userGroup = dpUserSession[0][4];
		session.data.userCompany = dpUserSession[0][5];
		session.data.userLogin = dpUserSession[0][6];
		session.data.userPass = dpUserSession[0][7];
		session.flush();
		doInit();
		init();
		benutzernameLogin.text = '';
		passwortLogin.text = '';
		changeContent('diagramContent');
		this.currentState = 'Portfolios';
	}else{
		loginFehler.text = 'Ihre Angaben waren fehlerhaft!';
	}
}

public function getUserResult(event:ResultEvent):void{
	dpUser = new ArrayCollection(ArrayUtil.toArray(event.result));
}

public function addUserResult(event:ResultEvent):void{
	threepv_service.getUser.send(session.data.userCompany);
	changeContent('alleBenutzerContent');
}

public function getMyPortfoliosResult(event:ResultEvent):ArrayCollection{
	
	dpPortfolio = new ArrayCollection(ArrayUtil.toArray(event.result));
	
	var length:int = event.result.length;
	if(length > 0){
		dpPortfolioSelector = new ArrayCollection();
		for(var i:int = 0; i < length; i++){
			dpPortfolioSelector.addItem(event.result[i][1]);
		}
		lblYAchse.text = dpPortfolio[0][6];
		lblXAchse.text = dpPortfolio[0][7];
	}else{
		dpPortfolioSelector = new ArrayCollection();
		dpPortfolioSelector.addItem('Keine Portfolios vorhanden...');
		lblYAchse.text = 'Y-Achse';
		lblXAchse.text = 'X-Achse';
	}
	
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
	threepv_service.getAttributes.send(portfolioID);
	threepv_service.getMyProjects.send(portfolioID);
	
	setAttrb(dpPortfolio);
	
	return dpPortfolio;
	//TODO: schleife, die bei jedem durchlauf die projektattribute in ein array speichert
	//threepv_service.getProjectAttributes(dpMyProjects[0][0]);
}

public function getAttributesResult(event:ResultEvent):void{
	dpPortfolioAttributes = new ArrayCollection(ArrayUtil.toArray(event.result));
	dpPortfolioAttributes.addItem('');
}

public function newProjectResult(event:ResultEvent):void{
	changeContent('listContent');
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
	var projektid:String = String(event.result);
	for(var i:int = 0; i < gridTeamNeu.dataProvider.length; i++){
		threepv_service.setBenutzerProjekt.send(gridTeamNeu.dataProvider[i][0], projektid);
	}
	//Eigenschaft 0 für String nicht gefunden Zeile 151
	for(var i:int = 0; i < gridAttributeNeu.dataProvider.length; i++){
		threepv_service.setProjectAttributes.send(projektid, gridAttributeNeu.dataProvider[i][0], gridAttributeNeu.dataProvider[i][5]);
	}
	
	threepv_service.getAttributes.send(portfolioID);
	threepv_service.getMyProjects.send(portfolioID);
	
	setAttrb(dpPortfolio);
	threepv_service.getMyProjects.send(portfolioID);
}

public function getMyProjectsResult(event:ResultEvent):void
{
	dpMyProjects = new ArrayCollection(ArrayUtil.toArray(event.result));
}

public function testResult(event:ResultEvent):void{
	Alert.show(event.result.toString());
}

import flash.net.SharedObject;

import mx.collections.ArrayCollection;
import mx.rpc.events.ResultEvent;
import mx.utils.ArrayUtil;

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


//Result Events - FlexRemoting
public function userLoginResult(event:ResultEvent):void{
	if(event.result){
		var session:SharedObject = SharedObject.getLocal("3PvSession");
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
		this.currentState = 'Portfolios';
	}else{
		loginFehler.text = 'Ihre Angaben waren fehlerhaft!';
	}
}

public function getUserResult(event:ResultEvent):void{
	dpUser = new ArrayCollection(ArrayUtil.toArray(event.result));
}

public function addUserResult(event:ResultEvent):void{
	threepv_service.getUser.send(1);
	changeContent('alleBenutzerContent');
}

public function getMyPortfoliosResult(event:ResultEvent):void{
	dpPortfolio = new ArrayCollection(ArrayUtil.toArray(event.result));
	var length:int = event.result.length;
	dpPortfolioSelector = new ArrayCollection();
	for(var i:int = 0; i < length; i++){
		dpPortfolioSelector.addItem(event.result[i][1]);
	}
	lblYAchse.text = dpPortfolio[0][6];
	lblXAchse.text = dpPortfolio[0][7];
}

public function getAttributesResult(event:ResultEvent):void{
	dpPortfolioAttributes = new ArrayCollection(ArrayUtil.toArray(event.result));
}

public function newProjectResult(event:ResultEvent):void{
	
}

public function getMyProjectsResult(event:ResultEvent):void
{
	dpMyProjects = new ArrayCollection(ArrayUtil.toArray(event.result));
}
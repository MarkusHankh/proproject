import flash.net.SharedObject;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.rpc.events.ResultEvent;
import mx.styles.StyleManager;
import mx.utils.ArrayUtil;

[Bindable]
public var session:SharedObject = SharedObject.getLocal("3PvSession");

//Variablen vom Backend
[Bindable]
public var dpUser:ArrayCollection;

[Bindable]
public var dpUserProject:ArrayCollection;

[Bindable]
public var dpPortfolioSelector:ArrayCollection;

[Bindable]
public var dpPortfolio:ArrayCollection;

[Bindable]
public var dpPortfolioAttributes:ArrayCollection;

[Bindable]
public var dpMyProjects:ArrayCollection;

[Bindable]
public var dpMyAttribute:ArrayCollection;

[Bindable]
public var dpUserSession:ArrayCollection;

[Bindable]
public var dpDefaultAttributeVisualisations:ArrayCollection;

[Bindable]
public var dgSpezifischeAttribute:ArrayCollection;

[Bindable]
public var dgSpezifischeAttributeZwei:ArrayCollection;

[Bindable]
public var dpPortfolioValues:ArrayCollection;

[Bindable]
public var dpProjectValues:ArrayCollection;

[Bindable]
public var dpProjectAttributesValues:ArrayCollection;

[Bindable]
public var dpProjectUser:ArrayCollection;

[Bindable]
public var dpGridTeamEdit:ArrayCollection;

[Bindable]
public var attributesCountFromDB:int;

[Bindable]
public var dpMySettings:ArrayCollection;

[Bindable]
public var dpAllMySettings:ArrayCollection;

//Result Events - FlexRemoting
public function registerResult(event:ResultEvent):void
{
	if(event.result)
	{
		var user:String = event.result[0];
		var pass:String = event.result[1];
		threepv_service.userLogin.send(user, pass);
	}
	else
	{
		Alert.show('Registrierung konnte nicht durchgeführt werden!');
	}
	
}

public function userLoginResult(event:ResultEvent):void
{
	if(event.result)
	{
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
	}
	else
	{
		loginFehler.text = 'Ihre Angaben waren fehlerhaft!';
	}
}

public function getUserResult(event:ResultEvent):void
{
	dpUser = new ArrayCollection(ArrayUtil.toArray(event.result));
	dpUserProject = new ArrayCollection(ArrayUtil.toArray(event.result));
}

public function addUserResult(event:ResultEvent):void
{
	threepv_service.getUser.send(session.data.userCompany);
	changeContent('alleBenutzerContent');
}

public function editUserResult(event:ResultEvent):void
{
	threepv_service.getUser.send(session.data.userCompany);
	changeContent('alleBenutzerContent');
	vornameEdit.text = '';
	nachnameEdit.text = '';
	benutzernameEdit.text = '';
	emailEdit.text = '';
	passwortEdit.text = '';
	passwort2Edit.text = '';
}

public function getMyPortfoliosResult(event:ResultEvent):ArrayCollection
{
	dpPortfolio = new ArrayCollection(ArrayUtil.toArray(event.result));
	var length:int = event.result.length;
	if(length > 0)
	{
		dpPortfolioSelector = new ArrayCollection();
		for(var i:int = 0; i < length; i++)
		{
			dpPortfolioSelector.addItem(event.result[i][1]);
		}
		lblYAchse.text = dpPortfolio[0][7];
		lblXAchse.text = dpPortfolio[0][6];
	}
	else
	{
		dpPortfolioSelector = new ArrayCollection();
		dpPortfolioSelector.addItem('Keine Portfolios vorhanden...');
		lblYAchse.text = 'Y-Achse';
		lblXAchse.text = 'X-Achse';
	}
	
	var portfolioName:String = portfolioSelector.text;
	var portfolioID:int=getCurrentPortfolioID();
	threepv_service.getAttributes.send(portfolioID);
	threepv_service.getMyProjects.send(session.data.userID, portfolioID);
	
	setAttrb(dpPortfolio);
	return dpPortfolio;
}

public function getAttributesResult(event:ResultEvent):void
{
	dpPortfolioAttributes = new ArrayCollection(ArrayUtil.toArray(event.result));
	dpPortfolioAttributes.addItem({bla: ADD_TASK});
	
	attributesCountFromDB=dpPortfolioAttributes.length-1;
}

public function newPortfolioResult(event:ResultEvent):void
{
	var portfolioID:String = String(event.result);
	for (var i:int=0; i < dgSpezifischeAttribute.length-1; i++)
	{
		threepv_service.setAttributes.send(portfolioID, dgSpezifischeAttribute[i][1], 'Beschreibung', dgSpezifischeAttribute[i][3]);
	}
	threepv_service.getMyPortfolios.send(session.data.userID);
	changeContent('diagramContent');
	
}

public function newProjectResult(event:ResultEvent):void
{
	changeContent('listContent');
	var projektid:String = String(event.result);
	var portfolioID:int=getCurrentPortfolioID();
	
	for(var i:int = 0; i < gridTeamNeu.dataProvider.length; i++)
	{
		threepv_service.setBenutzerProjekt.send(gridTeamNeu.dataProvider[i][0], projektid);
	}
 
 	for(var i:int = 0; i < gridAttributeNeu.dataProvider.length; i++)
 	{
 		try
 		{
   			var attributid:int = gridAttributeNeu.dataProvider[i][0].valueOf();
   			var attributwert:String = gridAttributeNeu.dataProvider[i][5];
  			threepv_service.setProjectAttributes.send(projektid, attributid, attributwert);
  		}
  		catch(e:Error)
  		{
   			//Do Nothing :)
  		}
 	}
	changeContent('diagramContent');
	setAttrb(dpPortfolio);
 	refreshAll(portfolioSelector.text);
}

public function getMyProjectsResult(event:ResultEvent):void
{
	var temp:ArrayCollection = new ArrayCollection(ArrayUtil.toArray(event.result));
	dpMyProjects = new ArrayCollection(ArrayUtil.toArray(event.result));
	dpMyAttribute = new ArrayCollection();
	projectAttributes(temp);
}

public function getDefaultAttributesVisualisationsResult(event:ResultEvent):void
{
	dpDefaultAttributeVisualisations = new ArrayCollection(ArrayUtil.toArray(event.result));
}

public function getPortfolioValuesResult(event:ResultEvent):void
{
	dpPortfolioValues = new ArrayCollection(ArrayUtil.toArray(event.result));
	
	portfolionameEdit.text=dpPortfolioValues[0][1];
	portfolioBeschreibungEdit.text=dpPortfolioValues[0][8];
	nameXAchseEdit.text=dpPortfolioValues[0][6];
	nameYAchseEdit.text=dpPortfolioValues[0][7];
	kleinsterXWertEdit.value=dpPortfolioValues[0][2];
	groessterXWertEdit.value=dpPortfolioValues[0][3];
	kleinsterYWertEdit.value=dpPortfolioValues[0][4];
	groessterYWertEdit.value=dpPortfolioValues[0][5];
}

public function getProjectValuesResult(event:ResultEvent):void
{
	dpProjectValues = new ArrayCollection(ArrayUtil.toArray(event.result));
	var formGroesse:String;
	switch(dpProjectValues[0][5])
	{
		case '1':
			formGroesse = 'Klein';
			break;
		case '2':
			formGroesse = 'Mittel';
			break;
		case '3':
			formGroesse = 'Groß';
			break;
	}
	
	projektnameEdit.text=dpProjectValues[0][1];
	startdatumEdit.text=dpProjectValues[0][2];
	enddatumEdit.text=dpProjectValues[0][3];
	formEdit.text=dpProjectValues[0][4];
	formgroesseEdit.text=formGroesse;
	xAchseEdit.value=dpProjectValues[0][6];
	yAchseEdit.value=dpProjectValues[0][7];
	beschreibungEdit.text=dpProjectValues[0][12];
	fuellfarbeEdit.selectedColor=StyleManager.getColorName(dpProjectValues[0][8]);
	rahmenfarbeEdit.selectedColor=StyleManager.getColorName(dpProjectValues[0][9]);
	ringfarbeInnenEdit.selectedColor=StyleManager.getColorName(dpProjectValues[0][10]);
	ringfarbeAussenEdit.selectedColor=StyleManager.getColorName(dpProjectValues[0][11]);
}



public function getProjectAttributesResult(event:ResultEvent):void
{
	
	dpProjectAttributesValues = new ArrayCollection(ArrayUtil.toArray(event.result));
	for(var i:int = 0; i < dpProjectAttributesValues.length; i++)
	{
  		dpPortfolioAttributes.setItemAt({0:dpPortfolioAttributes[i][0], 1:dpPortfolioAttributes[i][1], 3:dpPortfolioAttributes[i][3], 5:dpProjectAttributesValues[i][2]}, i);
 	}
}

public function getProjectUserResult(event:ResultEvent):void
{
	var temp:ArrayCollection=new ArrayCollection(ArrayUtil.toArray(event.result));
	dpGridTeamEdit=new ArrayCollection();
	for(var i:int=0; i<temp.length; i++)
	{
		//dpGridTeamEdit.addItem({'BenutzerID':temp[i][0], 'Benutzer':temp[i][1]});
		dpGridTeamEdit.addItem({0:temp[i][0], 1:temp[i][1]});
		for(var j:int=0; j<dpUserProject.length; j++)
		{
			if(dpGridTeamEdit[i][0]==dpUserProject[j][0])
			{
				dpUserProject.removeItemAt(j)
			}
		}
	}
}

public function getMySettingsResult(event:ResultEvent):void{
	var tempSettings:ArrayCollection = new ArrayCollection(ArrayUtil.toArray(event.result));
	if(tempSettings[0][1] != null){
		dpMySettings = new ArrayCollection(ArrayUtil.toArray(event.result));
	}else{
		standardSettings();
	}
}

public function getAllMySettingsResult(event:ResultEvent):void{
	if(event.result){
		dpAllMySettings = new ArrayCollection(ArrayUtil.toArray(event.result));
	}else{
		//Eigentlich nichts...glaube ich
	}
}

public function aktivateSettingResult(event:ResultEvent):void{
	threepv_service.getMySettings.send(session.data.userID);
}

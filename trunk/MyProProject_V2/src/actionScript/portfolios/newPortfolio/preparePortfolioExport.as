public function preparePortfolioExport():void
{
	/*Alert.show("UserID: " + session.data.userID.toString());
	Alert.show("Portfolioname: " + portfolionameNeu.text); 
	Alert.show("Beschreibung: " + portfolioBeschreibungNeu.text);
	Alert.show("Kleinster XWert: " + kleinsterXWertNeu.value.toString());
	Alert.show("Groesster XWert: " + groessterXWertNeu.value.toString());
	Alert.show("Kleinster YWert: " + kleinsterYWertNeu.value.toString());
	Alert.show("Groesster YWert: " + groessterYWertNeu.value.toString());
	Alert.show("X Achse Name: " + nameXAchseNeu.text); 
	Alert.show("Y Achse Name: " + nameYAchseNeu.text); 
	Alert.show("Firma: " + session.data.userCompany.toString());
	*/
	var userID:int = session.data.userID;
	var companyID:int =  session.data.userCompany;
	threepv_service.newPortfolio.send(portfolionameNeu.text, kleinsterXWertNeu.value, groessterXWertNeu.value, kleinsterYWertNeu.value, groessterYWertNeu.value, nameXAchseNeu.text, nameYAchseNeu.text, portfolioBeschreibungNeu.text, companyID);
	
	portfolionameNeu.text="";
	kleinsterXWertNeu.value=0;
	groessterXWertNeu.value=0;
	kleinsterYWertNeu.value=0;
	groessterYWertNeu.value=0;
	nameXAchseNeu.text="";
	nameYAchseNeu.text="";
	portfolioBeschreibungNeu.text="";
	
}

public function preparePortfolioEditExport():void
{
	/*Alert.show("UserID: " + session.data.userID.toString());
	Alert.show("Portfolioname: " + portfolionameNeu.text); 
	Alert.show("Beschreibung: " + portfolioBeschreibungNeu.text);
	Alert.show("Kleinster XWert: " + kleinsterXWertNeu.value.toString());
	Alert.show("Groesster XWert: " + groessterXWertNeu.value.toString());
	Alert.show("Kleinster YWert: " + kleinsterYWertNeu.value.toString());
	Alert.show("Groesster YWert: " + groessterYWertNeu.value.toString());
	Alert.show("X Achse Name: " + nameXAchseNeu.text); 
	Alert.show("Y Achse Name: " + nameYAchseNeu.text); 
	Alert.show("Firma: " + session.data.userCompany.toString());
	*/
	
	var portfolioID:int;
	var portfolioName:String = portfolioSelector.text;
	var companyID:int =  session.data.userCompany;
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
	
	threepv_service.editPortfolio.send(portfolioID, portfolionameEdit.text, kleinsterXWertEdit.value, groessterXWertEdit.value, kleinsterYWertEdit.value, groessterYWertEdit.value, nameXAchseEdit.text, nameYAchseEdit.text, portfolioBeschreibungEdit.text, companyID);
	
	portfolionameEdit.text="";
	kleinsterXWertEdit.value=0;
	groessterXWertEdit.value=0;
	kleinsterYWertEdit.value=0;
	groessterYWertEdit.value=0;
	nameXAchseEdit.text="";
	nameYAchseEdit.text="";
	portfolioBeschreibungEdit.text="";
	//threepv_service.getMyPortfolios.send(session.data.userID);
	refreshAll(portfolioSelector.text);
	changeContent('diagramContent');
	
}
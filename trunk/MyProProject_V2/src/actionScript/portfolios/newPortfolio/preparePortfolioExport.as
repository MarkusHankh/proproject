public function preparePortfolioExport():void
{
	Alert.show("UserID: " + session.data.userID.toString());
	Alert.show("Portfolioname: " + portfolionameNeu.text); 
	Alert.show("Beschreibung: " + portfolioBeschreibungNeu.text);
	Alert.show("Kleinster XWert: " + kleinsterXWertNeu.value.toString());
	Alert.show("Groesster XWert: " + groessterXWertNeu.value.toString());
	Alert.show("Kleinster YWert: " + kleinsterYWertNeu.value.toString());
	Alert.show("Groesster YWert: " + groessterYWertNeu.value.toString());
	Alert.show("X Achse Name: " + nameXAchseNeu.text); 
	Alert.show("Y Achse Name: " + nameYAchseNeu.text); 
	Alert.show("Firma: " + session.data.userCompany.toString());
	
	var userID:int = session.data.userID;
	var companyID:int =  session.data.userCompany;
	threepv_service.newPortfolio.send(portfolionameNeu.text, kleinsterXWertNeu.value, groessterXWertNeu.value, kleinsterYWertNeu.value, groessterYWertNeu.value, nameXAchseNeu.text, nameYAchseNeu.text, portfolioBeschreibungNeu.text, companyID);
}
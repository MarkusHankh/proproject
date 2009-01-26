public function preparePortfolioExport():void
{

	threepv_service.newPortfolio.send(session.data.userID, portfolionameNeu.text, kleinsterXWertNeu.text, groessterXWertNeu.text, kleinsterYWertNeu.text, groessterYWertNeu.text, nameXAchseNeu.text, nameYAchseNeu.text, portfolioBeschreibungNeu.text, session.data.userCompany);
}
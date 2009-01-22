
	import mx.states.SetProperty;
	public function changeContent(content:String):void{
		switch(content){
			case 'diagramContent':
				this.diagramContent.setVisible(true, false);
				this.listContent.setVisible(false, false);
				this.projektNeuContent.setVisible(false, false);
				this.portfolioNeuContent.setVisible(false, false);
				this.portfolioBearbeitenContent.setVisible(false, false);
				this.lblDiagramm.setStyle("color", "#0066ff");
				this.lblListe.setStyle("color", "#808492");
				this.lblNeuesProjekt.setStyle("color", "#808492");
				this.lblNeuesPortfolio.setStyle("color", "#808492");
				this.lblPortfolioBearbeiten.setStyle("color", "#808492");
				break;
			case 'listContent':
				this.diagramContent.setVisible(false, false);
				this.listContent.setVisible(true, false);
				this.projektNeuContent.setVisible(false, false);
				this.portfolioNeuContent.setVisible(false, false);
				this.portfolioBearbeitenContent.setVisible(false, false);
				this.lblDiagramm.setStyle("color", "#808492");
				this.lblListe.setStyle("color", "#0066ff");
				this.lblNeuesProjekt.setStyle("color", "#808492");
				this.lblNeuesPortfolio.setStyle("color", "#808492");
				this.lblPortfolioBearbeiten.setStyle("color", "#808492");
				break;
			case 'projektNeuContent':
				this.diagramContent.setVisible(false, false);
				this.listContent.setVisible(false, false);
				this.projektNeuContent.setVisible(true, false);
				this.portfolioNeuContent.setVisible(false, false);
				this.portfolioBearbeitenContent.setVisible(false, false);
				this.lblDiagramm.setStyle("color", "#808492");
				this.lblListe.setStyle("color", "#808492");
				this.lblNeuesProjekt.setStyle("color", "#0066ff");
				this.lblNeuesPortfolio.setStyle("color", "#808492");
				this.lblPortfolioBearbeiten.setStyle("color", "#808492");
				break;
			case 'portfolioNeuContent':
				this.diagramContent.setVisible(false, false);
				this.listContent.setVisible(false, false);
				this.projektNeuContent.setVisible(false, false);
				this.portfolioNeuContent.setVisible(true, false);
				this.portfolioBearbeitenContent.setVisible(false, false);
				this.lblDiagramm.setStyle("color", "#808492");
				this.lblListe.setStyle("color", "#808492");
				this.lblNeuesProjekt.setStyle("color", "#808492");
				this.lblNeuesPortfolio.setStyle("color", "#0066ff");
				this.lblPortfolioBearbeiten.setStyle("color", "#808492");
				break;
			case 'portfolioBearbeitenContent':
				this.diagramContent.setVisible(false, false);
				this.listContent.setVisible(false, false);
				this.projektNeuContent.setVisible(false, false);
				this.portfolioNeuContent.setVisible(false, false);
				this.portfolioBearbeitenContent.setVisible(true, false);
				this.lblDiagramm.setStyle("color", "#808492");
				this.lblListe.setStyle("color", "#808492");
				this.lblNeuesProjekt.setStyle("color", "#808492");
				this.lblNeuesPortfolio.setStyle("color", "#808492");
				this.lblPortfolioBearbeiten.setStyle("color", "#0066ff");
				break;
			case 'alleBenutzerContent':
				this.alleBenutzerContent.setVisible(true, false);
				this.benutzerNeuContent.setVisible(false, false);
				this.lblAlleBenutzer.setStyle("color", "#0066ff");
				this.lblBenutzerNeu.setStyle("color", "#808492");
				break;
			case 'benutzerNeuContent':
				this.alleBenutzerContent.setVisible(false, false);
				this.benutzerNeuContent.setVisible(true, false);
				this.lblAlleBenutzer.setStyle("color", "#808492");
				this.lblBenutzerNeu.setStyle("color", "#0066ff");
				break;
			case 'einstellungContent':
				this.einstellungContent.setVisible(true, false);
				this.logoUploadContent.setVisible(false, false);
				this.lblEinstellungAllgemein.setStyle("color", "#0066ff");
				this.lblLogoUpload.setStyle("color", "#808492");
				break;
			case 'logoUploadContent':
				this.einstellungContent.setVisible(false, false);
				this.logoUploadContent.setVisible(true, false);
				this.lblEinstellungAllgemein.setStyle("color", "#808492");
				this.lblLogoUpload.setStyle("color", "#0066ff");
				break;
			case 'hilfePPContent':
				this.hilfePPContent.setVisible(true, false);
				this.hilfeBVContent.setVisible(false, false);
				this.hilfeVideoContent.setVisible(false, false);
				this.lblHilfePP.setStyle("color", "#0066ff");
				this.lblHilfeBV.setStyle("color", "#808492");
				this.lblHilfeVideo.setStyle("color", "#808492");
				break;
			case 'hilfeBVContent':
				this.hilfePPContent.setVisible(false, false);
				this.hilfeBVContent.setVisible(true, false);
				this.hilfeVideoContent.setVisible(false, false);
				this.lblHilfePP.setStyle("color", "#808492");
				this.lblHilfeBV.setStyle("color", "#0066ff");
				this.lblHilfeVideo.setStyle("color", "#808492");
				break;
			case 'hilfeVideoContent':
				this.hilfePPContent.setVisible(false, false);
				this.hilfeBVContent.setVisible(false, false);
				this.hilfeVideoContent.setVisible(true, false);
				this.lblHilfePP.setStyle("color", "#808492");
				this.lblHilfeBV.setStyle("color", "#808492");
				this.lblHilfeVideo.setStyle("color", "#0066ff");
				break;
		}
	}
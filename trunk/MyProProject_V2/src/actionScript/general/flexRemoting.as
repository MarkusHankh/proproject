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


//Result Events - FlexRemoting
public function getUserResult(event:ResultEvent):void{
	dpUser = new ArrayCollection(ArrayUtil.toArray(event.result));
}

public function getMyPortfoliosResult(event:ResultEvent):void{
	dpPortfolio = new ArrayCollection(ArrayUtil.toArray(event.result));
	var length:int = event.result.length;
	dpPortfolioSelector = new ArrayCollection();
	for(var i:int = 0; i < length; i++){
		dpPortfolioSelector.addItem(event.result[i][1]);
	}
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
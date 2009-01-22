import actionScript.portfolios.diagramm.SimpleInfoData;
import actionScript.portfolios.diagramm.InfoShape;
import actionScript.portfolios.diagramm.ItemContainer;
import mx.rpc.events.ResultEvent;
import mx.rpc.events.FaultEvent;
import mx.controls.Alert;
import mx.containers.Panel;
import mx.controls.TextInput;
import mx.containers.FormItem;
import mx.containers.Accordion;
import mx.states.*;
import mx.controls.Button;
import actionScript.portfolios.diagramm.*

var interval;
function doInit() {
	interval = setInterval(addSampleCharts,2000);
}
var item1:ItemContainer;
var item2:ItemContainer;
var item3:ItemContainer;
function addSampleCharts(){
	clearInterval(interval);
	item1 = new ItemContainer(0,30,130,70,30,35);
	item2 = new ItemContainer(0,20,290,320,70,90);
	item3 = new ItemContainer(1,20,390,320,70,90);
	item1.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
	item1.addEventListener(MouseEvent.MOUSE_UP,mouseReleased);
	item1.addEventListener(MouseEvent.MOUSE_OVER,mouseOver);
	item1.addEventListener(MouseEvent.MOUSE_OUT,mouseOut);
	item2.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
	item2.addEventListener(MouseEvent.MOUSE_UP,mouseReleased);
	item3.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
	item3.addEventListener(MouseEvent.MOUSE_UP,mouseReleased);
	dia.addChild(item3);
	dia.addChild(item1);
	dia.addChild(item2);
}

var interval4drag;
var eve;
function mouseDown(event:MouseEvent):void {
	eve = event;
	interval4drag = setInterval(checkArea,50);
    eve.target.startDrag();
}
function checkArea(){
	if(eve.target.x + 20 > dia.width ){
		eve.target.x = dia.width - 21;
		clearInterval(interval4drag);
		eve.target.stopDrag();
	}
	if(eve.target.x - 20 < 0 ){
		eve.target.x = 21;
		clearInterval(interval4drag);
		eve.target.stopDrag();
	}
	if(eve.target.y + 20 > dia.height ){
		eve.target.y = dia.height - 21;
		clearInterval(interval4drag);
		eve.target.stopDrag();
	}
	if(eve.target.y - 20 < 0 ){
		eve.target.y =  21;
		clearInterval(interval4drag);
		eve.target.stopDrag();
	}
}

var info1:InfoShape;
function mouseOver(event:MouseEvent):void {
	eve = event;
	info1 = new InfoShape(25,eve.target.x,eve.target.y);
	var sd:SimpleInfoData = new SimpleInfoData("X="+eve.target.getXValue()," Y="+eve.target.getYValue());
	var sd2:SimpleInfoData = new SimpleInfoData("Popeyes Freundin","Olivia");
	info1.addInfo(sd);
	info1.addInfo(sd2);
	eve.target.info=info1;
	dia.rawChildren.addChild(info1);
	
}
function mouseOut(event:MouseEvent):void {
	dia.rawChildren.removeChild(info1);
	//Alert.show(eve.target.getXValue()+":" + eve.target.getYValue());
}
function mouseReleased(event:MouseEvent):void {
	event.target.stopDrag();
    trace(event.target.dropTarget.name);
}
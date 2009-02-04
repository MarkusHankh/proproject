import actionScript.portfolios.*;
import actionScript.portfolios.diagramm.*;

import com.flexoop.utilities.dateutils.DateUtils;

import mx.collections.ArrayCollection;
import mx.rpc.AbstractOperation;
import mx.rpc.AsyncToken;
import mx.states.*;
import flash.events.MouseEvent;
var interval;
var token:AsyncToken
var pros:ArrayCollection = new ArrayCollection();
function doInit() {
	//interval = setInterval(addCharts,2000);
	var session:SharedObject = SharedObject.getLocal("3PvSession");
	var ao:AbstractOperation = threepv_service.getOperation("getMyPortfolios");
	token  = ao.send(1);
	//addCharts();
}

function addCharts():void {
	clearInterval(interval);
	if(dpPortfolio != null && dpPortfolio.length > 0) {
		for(var i = 0; i< dpPortfolio.length; i++){
			trace(i);
		}
	}
	
}

function projectAttributes(attr:ArrayCollection):void{
	trace("attr.value "+attr.toString());
	trace("attr.length "+attr.length);
	if(attr != null && attr.length > 0) {
		for(var i = 0; i< attr.length; i++){
			trace(attr[i]);
			var shape: Number = ((attr[i][4] == "Dreieck")?0:1); 
			var td1:Date = new Date(Number(attr[i][2].toString().substr(0,4)),Number(attr[i][2].toString().substr(5,2))-1,Number(attr[i][2].toString().substr(8,2)));
			var td2:Date = new Date(Number(attr[i][3].toString().substr(0,4)),Number(attr[i][3].toString().substr(5,2))-1,Number(attr[i][3].toString().substr(8,2)));
			trace("anfang "+dayOfYear(td1));
			var heute:Date = new Date();
			var days:Number = dayOfYear(td2)-dayOfYear(td1);
			trace("days"+days);
			var erf:Number;
			var temp:ItemContainer = new ItemContainer(shape,attr[i][5],attr[i][6],attr[i][7],days,dayOfYear(heute), dayOfYear(td1),0,null,Number("0x"+attr[i][8].toString().substring(1)),Number("0x"+attr[i][9].toString().substring(1)),Number("0x"+attr[i][10].toString().substring(1)),Number("0x"+attr[i][11].toString().substring(1)));
			temp.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			temp.addEventListener(MouseEvent.MOUSE_UP,mouseReleased);
			temp.addEventListener(MouseEvent.MOUSE_OVER,mouseOver);
			temp.addEventListener(MouseEvent.MOUSE_OUT,mouseOut);
			temp.addEventListener(MouseEvent.DOUBLE_CLICK,doubleClick);
			temp.info = new InfoShape(25,0,0);
			temp.put("Anfang",attr[i][2]);
			temp.put("Ende",attr[i][3]);
			pros.addItem(temp);
			dia.addChild(temp);
		}
	}
}
private static function dayOfYear( date:Date ):Number {
	// add one as it has to include first of year
	return DateUtils.dateDiff( DateUtils.DAY_OF_MONTH, new Date( date.fullYear, DateUtils.monthAsNumber( DateUtils.JANUARY ), 1 ), date ) + 1;
}
function setAttrb(attr:ArrayCollection):void {
	//trace("attr "+dpPortfolio.length+"-"+attr);
	
	//TODO: Bitte folgende Attribute in der DB hizufügen
	// Prozetntsatz für die Erfüllung der Ringe
	// Form als int
	/* 
	
	if(dpPortfolio != null && dpPortfolio.length > 0) {
		for(var i = 0; i< dpPortfolio.length; i++){
			trace(i);
			var temp:ItemContainer = new ItemContainer();
			temp.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			temp.addEventListener(MouseEvent.MOUSE_UP,mouseReleased);
			temp.addEventListener(MouseEvent.MOUSE_OVER,mouseOver);
			temp.addEventListener(MouseEvent.MOUSE_OUT,mouseOut);
			pros.addItem(temp);
			dia.addChild(temp);
		}
	}
	*/
}


function shiftOntoTheDia(){
	for(var i = 0; i< pros.length; i++){
		
	}
}


var item1:ItemContainer;
var item2:ItemContainer;
var item3:ItemContainer;
var item4:ItemContainer;
function addSampleCharts(){
	clearInterval(interval);
	item1 = new ItemContainer(0,30,130,70,30,35);
	item2 = new ItemContainer(0,20,290,320,70,90);
	item3 = new ItemContainer(1,20,390,320,70,90);
	item4 = new ItemContainer(1,30,310,220,90,30);
	item1.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
	item1.addEventListener(MouseEvent.MOUSE_UP,mouseReleased);
	item1.addEventListener(MouseEvent.MOUSE_OVER,mouseOver);
	item1.addEventListener(MouseEvent.MOUSE_OUT,mouseOut);
	item2.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
	item2.addEventListener(MouseEvent.MOUSE_UP,mouseReleased);
	item2.addEventListener(MouseEvent.MOUSE_OVER,mouseOver);
	item2.addEventListener(MouseEvent.MOUSE_OUT,mouseOut);
	item3.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
	item3.addEventListener(MouseEvent.MOUSE_UP,mouseReleased);
	item3.addEventListener(MouseEvent.MOUSE_OVER,mouseOver);
	item3.addEventListener(MouseEvent.MOUSE_OUT,mouseOut);
	item4.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
	item4.addEventListener(MouseEvent.MOUSE_UP,mouseReleased);
	item4.addEventListener(MouseEvent.MOUSE_OVER,mouseOver);
	item4.addEventListener(MouseEvent.MOUSE_OUT,mouseOut);
	dia.addChild(item3);
	dia.addChild(item1);
	dia.addChild(item2);
	dia.addChild(item4);
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
	var sd1:SimpleInfoData = new SimpleInfoData("X="+eve.target.getXValue()," Y="+eve.target.getYValue());
	//var sd2:SimpleInfoData = new SimpleInfoData("Popeyes Freundin","Olivia");
	for(var i = 0; i< eve.target.sd.length; i++){
		info1.addInfo(eve.target.sd[i]);
	}
	info1.addInfo(sd1);
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
function doubleClick(event:MouseEvent):void {
	Alert.show("Hallo ich bin "+event.target.sd[0]);
}
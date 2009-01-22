import mx.controls.Alert;
import mx.events.DragEvent;

public function dragDropHandler(event:DragEvent):void {    
    var dragObj:Array=
        event.dragSource.dataForFormat("items") as Array; 

    var artistList:String='';
    for (var i:Number = 0; i < dragObj.length; i++) { 
        artistList+= dragObj[i].Name + '\n';
    }             
}
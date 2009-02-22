
import flash.events.Event;
import flash.net.FileReference;
import flash.net.URLRequest;
import flash.net.URLVariables;

import mx.controls.Alert;

var file:FileReference;

public function myUpload():void{
	file = new FileReference();
	file.addEventListener(Event.SELECT, senden);
	file.browse();
}

public function senden(event:Event):void{
	var req:URLRequest = new URLRequest("http://3pv.proproject.labasto.de/amfphp/services/3pv_service/fassade.php");
	req.data = new URLVariables("aktion=upload");
	try{
		file.upload(req, 'upload');
	}catch(error:Error){
		Alert.show("Upload fehlgeschlagen!");
	}
}
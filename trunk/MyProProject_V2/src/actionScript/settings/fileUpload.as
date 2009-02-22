
import flash.events.Event;
import flash.net.FileReference;
import flash.net.URLRequest;
import flash.net.URLVariables;

import mx.formatters.NumberFormatter;

var file:FileReference;

public function myUpload():void{
	file = new FileReference();
	file.addEventListener(Event.SELECT, sendFile);
	file.addEventListener(ProgressEvent.PROGRESS, progress);
	file.addEventListener(Event.COMPLETE, complete);
	file.browse();
	uploadMessage.text = '';
}

public function sendFile(event:Event):void{
	var params:URLVariables = new URLVariables();
	params.aktion = 'upload';
	params.name = schemaNameNeu.text;
	params.hintergrundfarbe = hintergrundfarbeNeu.selectedColor.toString(16);
	params.schriftfarbe = schriftfarbeNeu.selectedColor.toString(16);
	params.schriftart = schriftartNeu.text;
	params.schriftgroesse = schriftgroesseNeu.text;
	params.hintergrundbild = hintergrundbildNeu.text;
	params.benutzer = session.data.userID;
	var req:URLRequest = new URLRequest("http://3pv.proproject.labasto.de/amfphp/services/3pv_service/fassade.php");
	req.method = URLRequestMethod.POST;
	req.data = params;
	try{
		var numberFormatter:NumberFormatter = new NumberFormatter();
		file.upload(req, 'upload');
	}catch(error:Error){
		uploadMessage.text = "ERROR: zero-byte file";
	}
}

public function progress(event:Event):void{
	progressBar.visible = true;
}

public function complete(event:Event):void{
	uploadMessage.text = "Upload erfolgreich!";
    progressBar.visible = false;
}

import flash.events.Event;
import flash.net.FileReference;
import flash.net.URLRequest;
import flash.net.URLVariables;

var file:FileReference;

public function myUpload():void{
	file = new FileReference();
	file.addEventListener(Event.SELECT, waitForUser);
	file.addEventListener(ProgressEvent.PROGRESS, progress);
	file.addEventListener(Event.COMPLETE, complete);
	file.browse();
	uploadMessage.text = '';
}

public function waitForUser(event:Event):void{
	btnDateiUpload.visible = false;
	uploadMessage.text = 'Datei: ' + file.name + ' ausgewählt';
}

public function sendFile():void{
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
		file.upload(req, 'upload');
	}catch(error:Error){
		//hier muss noch ne Methode auf der Fassade aufgerufen werden, die den Kram auch ohne Logo speichert
	}
}

public function progress(event:Event):void{
	progressBar.visible = true;
}

public function complete(event:Event):void{
	uploadMessage.text = "Upload erfolgreich!";
	lblSchemaGespeichert.text = "Schema wurde gespeichert";
    progressBar.visible = false;
    resetSchemaForm();
}

public function resetSchemaForm():void{
	schemaNameNeu.text = '';
	hintergrundfarbeNeu.selectedColor = 000000;
	schriftfarbeNeu.selectedColor = 000000;
	schriftartNeu.selectedIndex = 0;
	hintergrundbildNeu.selectedIndex = 0;
	schriftartNeu.selectedIndex = 0;
	schriftgroesseNeu.selectedIndex = 0;
	uploadMessage.text = '';
	btnDateiUpload.visible = true;
	
}

import flash.events.Event;
import flash.net.FileReference;
import flash.net.URLRequest;
import flash.net.URLVariables;

public var file:FileReference;

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
	params.hintergrundbild
	if(hintergrundbildNeu.text == 'schwarz'){
		params.hintergrundbild = 'bg_blank_raster.png';
	}else{
		params.hintergrundbild = 'bg_raster_silver.png';
	}
	params.benutzer = session.data.userID;
	var req:URLRequest = new URLRequest("http://3pv.proproject.labasto.de/amfphp/services/3pv_service/fassade.php");
	req.method = URLRequestMethod.POST;
	req.data = params;
	try{
		file.upload(req, 'upload');
	}catch(error:Error){
		var name:String = schemaNameNeu.text;
		var hintergrundfarbe:String = hintergrundfarbeNeu.selectedColor.toString(16);
		var schriftfarbe:String = schriftfarbeNeu.selectedColor.toString(16);
		var schriftart:String = schriftartNeu.text;
		var schriftgroesse:String = schriftgroesseNeu.text;
		var hintergrundbild:String;
		if(hintergrundbildNeu.text == 'schwarz'){
			hintergrundbild = 'bg_blank_raster.png';
		}else{
			hintergrundbild = 'bg_raster_silver.png';
		}
		var benutzer:int = session.data.userID;
		threepv_service.setSettings.send(name, hintergrundfarbe, schriftfarbe, schriftart, schriftgroesse, hintergrundbild, benutzer);
		lblSchemaGespeichert.text = "Schema wurde gespeichert";
		resetSchemaForm();
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

public function refreshSchema(schema:String):void{
	var schemaID:int=getCurrentSchemaID();
	
}

public function getCurrentSchemaID():int
{
	var schemaName:String = schemaSelector.text;
	var schemaID:int;
	if (dpAllMySettings != null){
		for (var i:int=0; i < dpSchemaSelector.length; i++){
			if (dpAllMySettings.length > 0 && dpAllMySettings[i][1] == schemaName){
				schemaID = dpAllMySettings[i][0];
			}
		}
	}
	else{
		Alert.show("dpSchema ist null!");
	}
	return schemaID;
}
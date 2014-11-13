package mx.random.cms{
import flash.events.*;
import flash.net.FileFilter;
import flash.net.FileReference;
import flash.net.FileReferenceList;
import flash.net.URLRequest;

[Bindable]
public class UploadFiles extends FileReferenceList {
	    private var uploadURL:URLRequest;
	    private var pendingFiles:Array;
		public var 	message:String = "";
		public var 	totalFiles:Number = 0;
		public var 	currentFile:Number = 0;
		public var 	actualFile:String = "";
		public var 	progressFile:Number = 0; 
		
	    public function UploadFiles(uploadDir:String) {
	        uploadURL 		= new URLRequest();
	        uploadURL.url 	= "http://www.latranquila.com.mx/___PublicData/___UPLOADER/UploadScript.php?up="+uploadDir;
	        initializeListListeners();
	    }
	
	    private function initializeListListeners():void {
	        addEventListener(Event.SELECT, selectHandler);
	        //addEventListener(Event.CANCEL, cancelHandler);
	    }
	
	    public function getTypes():Array {
	        var allTypes:Array = new Array();
	        allTypes.push(getImageTypeFilter());
	        allTypes.push(getTextTypeFilter());
	        return allTypes;
	    }
	 
	    private function getImageTypeFilter():FileFilter {
	        return new FileFilter("Imagenes (*.jpg, *.gif, *.png, *.bmp)", "*.jpg;*.gif;*.png;*.bmp;");
	    }
	 
	    private function getTextTypeFilter():FileFilter {
	        return new FileFilter("Archivos (*.txt, *.doc, *.docx, *.xls, *.xlsx, *.zip, *.rar)", "*.txt;*.doc;*.docx;*.xls;*.xlsx;*.zip;*.rar;");
	    }
	 
	    private function doOnComplete():void {
	        dispatchEvent(new Event("LIST_COMPLETE"));
	    }
	 
	    private function addPendingFile(file:FileReference):void {
	        message = "addPendingFile: name=" + file.name;
	        pendingFiles.push(file);
	        file.addEventListener(Event.OPEN, openHandler);
	        file.addEventListener(Event.COMPLETE, completeHandler);
	        file.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
	        file.addEventListener(ProgressEvent.PROGRESS, progressHandler);
	        file.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
	        file.upload(uploadURL);
	    }
	 
	    private function removePendingFile(file:FileReference):void {
	    	currentFile++;
	    	progressFile = Math.round((currentFile*100)/totalFiles);
	    	dispatchEvent(new Event("LIST_UPDATE"));
	        for (var i:uint; i < pendingFiles.length; i++) {
	        	
	            if (pendingFiles[i].name == file.name) {
	                pendingFiles.splice(i, 1);
	                
	                if (pendingFiles.length == 0) {
	                    doOnComplete();
	                }else{
	                	actualFile = pendingFiles[pendingFiles.length-1].name;
	                }
	                
	                return;
	            }
	        }
	    }
	 
	    private function selectHandler(event:Event):void {
	    	totalFiles = fileList.length;
	    	currentFile = 0;
	        message = "selectHandler: " + fileList.length + " files";
	        pendingFiles = new Array();
	        var file:FileReference;
	        for (var i:uint = 0; i < fileList.length; i++) {
	            file = FileReference(fileList[i]);
	            addPendingFile(file);
	        }
	       	actualFile = pendingFiles[pendingFiles.length-1].name;
	       	dispatchEvent(new Event("LIST_READY"));
	    }
	 
	    private function cancelHandler(event:Event):void {
	        var file:FileReference = FileReference(event.target);
	        //message = "cancelHandler: name=" + file.name;
	    }
	    
	    public function selectFiles():void{
	    	browse(getTypes());
	    }
	    
	    public function cancelUpload():void{
	    	pendingFiles = new Array();
	    }
	 
	    private function openHandler(event:Event):void {
	        var file:FileReference = FileReference(event.target);	       
	        message = "openHandler: name=" + file.name;	        
	    }
	 
	    private function progressHandler(event:ProgressEvent):void {
	        var file:FileReference = FileReference(event.target);
	        message = "progressHandler: name=" + file.name + " bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal;
	    }
	 
	    private function completeHandler(event:Event):void {
	        var file:FileReference = FileReference(event.target);
	        message = "completeHandler: name=" + file.name;
	        removePendingFile(file);
	    }
	 
	    private function httpErrorHandler(event:Event):void {
	        var file:FileReference = FileReference(event.target);
	        message = "httpErrorHandler: name=" + file.name;
	    }
	 
	    private function ioErrorHandler(event:Event):void {
	        var file:FileReference = FileReference(event.target);
	        message = "ioErrorHandler: name=" + file.name;
	    }
	 
	    private function securityErrorHandler(event:Event):void {
	        var file:FileReference = FileReference(event.target);
	        message = "securityErrorHandler: name=" + file.name + " event=" + event.toString();
	    }
	}	

}
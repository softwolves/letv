
function getXhr(){
	var xhr = null;
	if(window.XMLHttpRequest){
		//非ie
		xhr = new XMLHttpRequest();
	}else{
		//ie
		xhr = new ActiveXObject(
				'Microsoft.XMLHttp');
	}
	return xhr;
}
//= require jquery
//= require jquery_ujs

function init_ck_editor(){
	if(CKEDITOR.instances['rich-text-area']) 
		return;
	if($('#rich-text-area').length > 0)
    	CKEDITOR.replace( "rich-text-area" )
}
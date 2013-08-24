// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui-1.10.2.custom.min
//= require jquery_ujs
//= require bootstrap.min
//= require common
//= require jLinedTextarea
//= require jquery.display_star_rating
//= require jquery.minicolors
//= require survey_builder

//= require jVectorMap.min
//= require jVectorMap.world
//= require scroll-sticky
//= require chart
//= require jSignature.min
//= require rails.validations
//= require rails.validations.formtastic


$(function(){
	$('body').on('hidden', '.modal', function(){
		$(this).removeData('modal');
	})

	//flash mesages close button
	$(document).on('click', '.flash-message a.close', function(){
		$(this).parents('.flash-message-outer').fadeOut(300, function(){
			$(this).remove();
		})
	})
});

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
//= require jquery_ujs
//= require common
//= require_tree .


function sticky_relocate() {
	var window_top = $(window).scrollTop();
	var div_top = $('#sticky-anchor').offset().top;
	if (window_top > div_top)
		$('#stickyBar').addClass('stick')
	else
		$('#stickyBar').removeClass('stick')
}

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
	if($('#stickyBar').length > 0){
		$(window).scroll(sticky_relocate);
		sticky_relocate();
	}
});

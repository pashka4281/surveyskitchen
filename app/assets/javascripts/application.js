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
//= require jquery-ui-1.9.1.custom.min
//= require jquery_ujs
//= require twitter/bootstrap/bootstrap-modal
//= require twitter/bootstrap/bootstrap-alert
//= require twitter/bootstrap/bootstrap-transition
//= require twitter/bootstrap/bootstrap-dropdown
//= require twitter/bootstrap/bootstrap-collapse
//= require common
//= require_tree .

// require twitter/bootstrap


$(function(){
	$('body').on('hidden', '.modal', function(){
		$(this).removeData('modal');
	})
});





/*
 * Content-Type:text/javascript
 *
 * A bridge between iPad and iPhone touch events and jquery draggable,
 * sortable etc. mouse interactions.
 * @author Oleg Slobodskoi
 *
 * modified by John Hardy to use with any touch device
 * fixed breakage caused by jquery.ui so that mouseHandled internal flag is reset
 * before each touchStart event
 *
 * modified by Daniel Evans to use the _mouseCapture event, which respects the handle
 * option on sortable
 *
 */
(function($){
  $.support.touch = true; // typeof Touch === 'object';
 
  if (!$.support.touch){
    return;
  }
 
  var proto =  $.ui.mouse.prototype,
  _mouseInit = proto._mouseInit;
 
  $.extend(proto, {
    _getElementToBind: function(){
      var el = this.element;
      if(this.widgetName == "sortable"){
        console.log
      }
      return el;
    },
 
    _mouseInit: function(){
      this._getElementToBind().bind("touchstart." + this.widgetName, $.proxy(this, "_touchStart"));
      _mouseInit.apply(this, arguments);
    },
 
    _touchStart: function(event){
      if (event.originalEvent.targetTouches.length != 1){
        return false;
      }
 
      if(!this._mouseCapture(event, false)){ // protects things like the "handle" option on sortable
        return true;
      }
 
      this.element
        .bind("touchmove." + this.widgetName, $.proxy(this, "_touchMove"))
        .bind("touchend." + this.widgetName, $.proxy(this, "_touchEnd"));
 
      this._modifyEvent(event);
 
      $(document).trigger($.Event("mouseup")); // reset mouseHandled flag in ui.mouse
      this._mouseDown(event);
 
      return false;
    },
 
    _touchMove: function(event){
      this._modifyEvent(event);
      this._mouseMove(event);
    },
 
    _touchEnd: function(event){
      this.element
        .unbind("touchmove." + this.widgetName)
        .unbind("touchend." + this.widgetName);
      this._mouseUp(event);
    },
 
    _modifyEvent: function(event){
      event.which = 1;
      var target = event.originalEvent.targetTouches[0];
      event.pageX = target.clientX;
      event.pageY = target.clientY;
    }
 
  });
 
})(jQuery);
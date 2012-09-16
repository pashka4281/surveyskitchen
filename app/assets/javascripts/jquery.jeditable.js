(function($) {

    $.fn.tinyEditor = function(url, options) {
      var defaults = {
        triggeringElement: options['triggeringElement'],
        postName: options['postName'] || 'value',
        method: 'PUT'
      }
            
      options =  $.extend(defaults, options);

      var self = this;


    }
})(jQuery);
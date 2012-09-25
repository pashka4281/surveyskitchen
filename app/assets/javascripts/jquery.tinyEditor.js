(function($) {

    $.fn.tinyEditor = function(url, options) {
      var defaults = {
        triggeringElement: options['triggeringElement'],
        postName: options['postName'] || 'value',
        method: 'PUT'
      }
      var self = this;

      self.css('float', 'left')
      options = $.extend(defaults, options);

      
      var wrapper = $('<div class="tinyEditorWrapper eight mobile-four"></div>');
      self.wrap(wrapper);

      var form = $('<form method="' + defaults['method'] + '" action="' + url + '"></form>')
        .insertAfter(self)
        .css({'padding':0, 'margin':0});
      var editButton = $('<img src="/images/icons/edit.png" alt="Edit" class="tinyEditorButton" />').insertAfter(self);

      editButton.click(function(){
        self.hide();
        form.find('input').remove();
		    var input = $('<input type="text" name="' + defaults['postName'] + '" class="tinyEditorInputField"></input>')
          .appendTo(form).val(self.text()).focus();
      });

      $('body').click(function(e){
        var target = $(e.target);
        if(!target.hasClass('tinyEditorInputField') && !target.hasClass('tinyEditorButton')){
          form.find('input').remove();
          self.show();
        }
      });

    }
})(jQuery);
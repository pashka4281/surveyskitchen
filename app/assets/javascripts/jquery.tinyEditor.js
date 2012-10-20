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

      
      var wrapper = $('<div class="tinyEditorWrapper"></div>');
      self.wrap(wrapper);

      var form = $('<form method="' + defaults['method'] + '" action="' + url + '"></form>')
        .insertAfter(self);
      var editButton = $('<span class="tinyEditorButton label label-success"><i class="icon-pencil" /> edit</span>')
        .insertAfter(self);

      var input = $('<input type="text" name="' + defaults['postName'] + '" class="tinyEditorInputField"></input>')
          .appendTo(form)
          .val(self.text())
          .focus().hide()
          .blur(hideEditor);

      function hideEditor(){
        self.show();
        input.hide()
      }

      editButton.click(function(){
        self.hide();
		    input.show()
          .val(self.text())
          .focus();
      });

      $('body').click(function(e){
        var target = $(e.target);
        if(!target.hasClass('tinyEditorInputField') && !target.hasClass('tinyEditorButton'))
          hideEditor();
      });

      // preventing form from being submitted in regular way, making it ajaxy :)
      form.submit(function(e){
        e.preventDefault();
        $.ajax(url, {
          type: options['method'],
          success: function(){
            hideEditor()
          }
        })
      })

    }
})(jQuery);
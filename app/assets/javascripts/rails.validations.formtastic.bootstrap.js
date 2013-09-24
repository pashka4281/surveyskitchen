(function() {
 
  ClientSideValidations.formBuilders['FormtasticBootstrap::FormBuilder'] = {
    add: function(element, settings, message) {
      var errorElement, wrapper;
      if (element.data('valid') !== false) {
        wrapper = element.closest('div.input');
        errorElement = $('<span/>', {
          "class": 'help-inline',
          text: message
        });
        wrapper.addClass('error');
        return wrapper.find('.controls').append(errorElement);
      } else {
        return element.parent().find("span.help-inline").text(message);
      }
    },
    remove: function(element, settings) {
      var errorElement, wrapper;
      wrapper = element.closest('div.input.error');
      errorElement = wrapper.find("span.help-inline");
      wrapper.removeClass('error');
      return errorElement.remove();
    }
  };
 
}).call(this);
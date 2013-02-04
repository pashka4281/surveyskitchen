(function($) {
	$.fn.jDisplayStars = function(op) {
		var defaults = {
			 bigStarImg : 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABcAAAAUCAYAAABmvqYOAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA5xJREFUeNqsVF1v21QY9vFX4jhO7CRTSlHbtBXVAmoFLRdV1WmBTXALEr8AadfccLOfsUvuEAJuuJgQ4n40dJtGR1VYx6J0/VDTNInbfNhNbcf2MY/bphvbRCNtRzqJ/fqc57zv8zznJQEGM8BoNBrfCYKQ0DTtM2bAwQ6yyHXdrXL5ya+bm+VfKKXNNwke7Ozs/Dg+/jajKFKnVqv99MbAj4+t1Xp9729F0TLZ7HC6VPqniEoqrw0OOdxyufTDxMS46HmMSCmRcrlRurW19W34+bXAdV2/zTD+niwrSchOGIaw6XRGa7UO1g3DWLoInPTd4nlevdfrVW3b3u92u9vNZnPbsrqVqal3FI4T5L6nWJYwjmMZpVLZ1rTUaDKZzMmynItGo0Nw0zDP85lz8P39/e8h2ArPs6bvUxMLLFVNsMmkKkYiERWx+NnSZxmRk0MMx7GNVqtlt9sG4/t+jOO4hOf58cnJySuZTOZzPh6PT1Yquz8XCgueJCkqrHYpCAiPTFnfBxeEDQghL/AbEEqZhCBElGz2rWBoaMjjOLar67XayspfyZmZmalzWkDDn8vLd27Nzn4giKKshPyy7IkcYjgBLuCfOxPRD62P2QsFpzRgOI6hhtFsP3r0RCwUPr4piuL4fzjvdDq/F4t3vllYmJcEQUpjUxKgMg7hMPFI2FMDnQ5U6OHXBBWGabb1Bw/+CK5f//TrWCz23ktugTCLi4tXv1xaKh5b1hEASSIExgC/bIDp45liBqcxjkdMNYwWXV6+6wP4q+eBX7Kiqqofzc9f+WJjo6wD3A6pQcYhOHN2CNOPgeNQWGt9/XH72rVPbgD4/Qt9nkpps47jcpT6dh/sVTM8AGsssBVJJBJzA10iXG00JmrzPCc8sx45r6D/HA7YVrTt4y5saA4E7jhORxA4HxmJZ1pTYOE9cKCnE773uzTWCLgfFAkdvAqcfzFgWZaO2xb6HJkyfhB4HcNoHzx9um2hGoI+I0ejsQwOVEIbxuMyjz01cP7uheBHR+YhWisqctvVar2+u1vpgYDRfD5fQIbOw4drvwkC2UADk3ALL8myhD1HejqdvjjzRqO+Z1mN5traY3dkZOJyPj9zFRs/BM9c6PVsNruIhna/VCoV7927v5FKSV3X5atjY2P/D47mZXY6JvU8IT83NzevaeoIRFNQdhVWjJ4IQKmjKEpueno6fXg4vLm6unqXZbsO4i4EF57H+1eAAQAZSMINqxQlmgAAAABJRU5ErkJggg==' // path of the icon stars.png
		   , length:5 // number of star to display
			
		};
		var star_width = 23;
		var opts = $.extend(defaults, op)
		
		$.each(this, function(i,el){
			var _el       = $(el),
			rating        = _el.data('rating'),
			size          = _el.data('size'),
			outer_width   = star_width * size,
			width_percent = rating / size * outer_width + 'px',
			rating_bg     = $('<div class="star-bg"></div>').css({	width: width_percent }),
			rating_outer  = $('<div class="rating-outer"></div>').css({	width: outer_width + 'px'	}),
			rating_value  = $('<div class="rating-value">'+ rating +'</div>');

			rating_bg.appendTo(_el);
			rating_outer.appendTo(_el);
			rating_value.appendTo(_el);
		})
		
		return this;
	}
})(jQuery);
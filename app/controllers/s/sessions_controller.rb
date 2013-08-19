module S
	class SessionsController < BaseController
		# include AuthenticationSystem    TODO: create this module!
		before_filter :get_survey

		#GET /s/3245fdc/auth
		def new

		end

	end
end
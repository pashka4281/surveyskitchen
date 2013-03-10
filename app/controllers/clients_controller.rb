class ClientsController < ApplicationController
	layout 'application'
	before_filter :authenticate_user!
	inherit_resources
	
  	actions :all
end

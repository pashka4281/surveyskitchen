class ClientsController < ApplicationController
	layout 'application'
	before_filter :authenticate_user!
	inherit_resources
	
  	actions :all


  	def create
  		if params[:clients_list]
  			@result = Client.create_from_csv_string(current_account, params[:clients_list])
  		end
  		@unprocessed_lines = @result[:unprocessed_lines]

  		render 'new' and return unless @unprocessed_lines.blank?
  		redirect_to action: 'new'
  	end
end

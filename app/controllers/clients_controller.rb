class ClientsController < ApplicationController
	layout 'application'
	before_filter :authenticate_user!
	inherit_resources
	
	actions :all

	def create
		if params[:clients_list]
			@result = Client.create_from_csv_string(current_account, params[:clients_list])
			@unprocessed_lines = @result[:unprocessed_lines]
			@processed_count = @result[:saved]
			@unsaved_count = @result[:unsaved]
			flash.now[:info] = "#{ I18n.t("clients.new.processed", num: @processed_count) } #{ I18n.t("clients.new.unsaved", num: @unsaved_count) }"
			render 'new' and return unless @unprocessed_lines.blank?
			redirect_to new_client_path, flash:{
				info: "#{ I18n.t("clients.new.processed", num: @processed_count) } #{ I18n.t("clients.new.unsaved", num: @unsaved_count) }" } and return
		end

		redirect_to action: 'new'
	end
end

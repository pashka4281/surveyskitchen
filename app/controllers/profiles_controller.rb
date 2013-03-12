class ProfilesController < ApplicationController
	before_filter :authenticate_user!
	before_filter :load_user
	
	def show

	end

	def edit
		
	end

	def update
		I18n.locale = params[:user][:language] if params[:user][:language]
		if @user.update_attributes(params[:user])
			flash[:success] = t("profiles.update.success")
		else
			flash[:error] = t("profiles.update.error")
		end
		redirect_to action: 'edit'
	end

	private

	def load_user
		@user = current_user
	end
  	
end

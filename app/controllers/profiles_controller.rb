class ProfilesController < ApplicationController
	before_filter :authenticate_user!
	before_filter :load_user
	
	def show

	end

	def edit
		
	end

	def update
		I18n.locale = params[:user][:language] if params[:user][:language]
		
		if (params[:user].keys & ['email', 'first_name', 'last_name']).any?
			unless @user.authenticate(params[:user].delete(:current_password))
				flash[:error] = t('profiles.edit.wrong_current_password')
				redirect_to action: 'edit' and return			
			end
		end

		if @user.update_attributes(params[:user])
			flash[:success] = t("profiles.update.success")
		else
			flash[:error] = @user.errors.full_messages# t("profiles.update.error")
		end
		redirect_to action: 'edit'
	end
  	
end

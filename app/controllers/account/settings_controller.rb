class Account::SettingsController < ApplicationController
  before_filter :authenticate_user!

  def show
  	@account = current_account
  end

  def info
  	@account = current_account
  end


  def edit
  end

  def update
  end
end

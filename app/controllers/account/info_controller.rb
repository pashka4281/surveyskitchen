class Account::InfoController < ApplicationController
  before_filter :authenticate_user!

  def details
  	@account = current_account
  end

  def index
  	@account = current_account
  end
end

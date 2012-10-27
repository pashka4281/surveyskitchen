class HomeController < ApplicationController

  def index
  	redirect_to :dashboard and return if user_signed_in?
  	render layout: 'clear'
  end
end

class HomeController < ApplicationController

  def index
  	redirect_to :dashboard and return if current_user
  	render layout: 'clear'
  end
end

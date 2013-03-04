class HomeController < ApplicationController
  layout 'clear'

  def index
  	redirect_to :dashboard and return if current_user
  	render layout: 'clear'
  end


  def about
  end

  def tos
  end

  def plans
  end

  def features
    
  end
end

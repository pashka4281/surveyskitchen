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

  def switch_locale
    lang_from_param  = (["en", "ru"] & [params[:lang]]).first
    cookies.permanent[:remember_locale] = { :value => lang_from_param, :domain => :all }
    redirect_back_or_default_url
  end
end

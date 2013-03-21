class HomeController < ApplicationController
  layout 'clear'
  skip_before_filter :set_locale
  before_filter :set_locale_marketing

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

  def locale_redirect
    redirect_to "/#{(I18n.locale || I18.n.default_locale)}"
  end
end

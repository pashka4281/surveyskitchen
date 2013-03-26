class HomeController < ApplicationController
  layout 'clear'
  skip_before_filter :set_locale
  before_filter :set_locale_marketing
  caches_page :index, :about, :plans, :features

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

  #"Know more" actions:
  def know_more_builder
  end

  def know_more_collect
  end

  def know_more_analyze
  end

  #root path
  def locale_redirect
    redirect_to "/#{(I18n.locale || I18.n.default_locale)}"
  end
end

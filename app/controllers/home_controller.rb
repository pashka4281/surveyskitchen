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


  def know_more
    raise ActionController::RoutingError unless %w(collect analyze builder ssl).include?(params[:subject])
    render "/home/know_more/#{params[:subject]}"
    # render text: subject.inspect
  end

  #root path
  def locale_redirect
    redirect_to current_user ? dashboard_path : "/#{ I18n.locale }"
  end
end

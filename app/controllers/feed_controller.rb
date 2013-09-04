class FeedController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_user

  def index
    @responses = current_account.responses.order('created_at DESC').page(params[:page]).per(10)
    @resp_days = @responses.group_by{|r| r.created_at.beginning_of_day }
  end

end

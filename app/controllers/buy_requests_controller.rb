class BuyRequestsController < InheritedResources::Base
  layout 'clear'
  skip_before_filter :set_locale
  before_filter :set_locale_marketing

  def create
  	@buy_request = BuyRequest.new(params[:buy_request])
  	if @buy_request.save
  		render 'thanks'
  	else
  		render 'new'
  	end
  end
end

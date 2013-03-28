class ResponsesController < ApplicationController
	before_filter :authenticate_user!
	
	def show
		@survey       = current_account.surveys.find(params[:survey_id])
		@survey_items = @survey.items
		@response     = @survey.responses.find(params[:id])
	end

	def index
		@survey          = current_account.surveys.find(params[:survey_id])
		@responses       = @survey.responses.order('created_at DESC').page(params[:page])
		@responses_count = @survey.responses.count
		@geodata         = get_geodata(@responses.map{|x| x.geodata[:country_code] rescue nil })
	end

	def destroy
		@survey   = current_account.surveys.find(params[:survey_id])
		@response = @survey.responses.find(params[:id])
		@response.destroy

		redirect_to survey_responses_path(@survey)
	end

private
	# ['ua', 'ua', 'us']  => {'ua' => 2, 'us' => 1}
	def get_geodata(country_codes)
		counts = Hash.new(0)
		country_codes.compact.each { |name| counts[name] += 1 }
		counts
	end
end

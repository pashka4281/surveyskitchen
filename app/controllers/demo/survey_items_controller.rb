class Demo::SurveyItemsController < ApplicationController
	helper :all
	before_filter :get_survey
	skip_before_filter :set_locale
	before_filter :set_locale_marketing

	def edit
		@survey_item = @survey.items.find(params[:id])
		render '/survey_items/edit', layout: false
	end

	def update
		@survey_item = @survey.items.find(params[:id])
		@survey_item.update_attributes(params[:survey_item])
		render '/survey_items/update'
	end
	
	def	create
		@item_type = params[:item_type]
		@item = get_item_constant(@item_type).new(survey_id: @survey.id, previous_item_id: params[:previous_item_id])
		unless @item.save
			render json: {errors: @item.errors.full_messages.to_sentence}.to_json, status: :unprocessible_entry
		end
		render '/survey_items/create'
	end

	def move
		@item = @survey.items.find(params[:item_id])
		@item.previous_item_id = params[:previous_item_id]
		@item.move_to_position()
		render nothing: true, status: 200
	end
	
	def destroy
  		@item = @survey.items.find(params[:id])
  		@item.destroy
  		render '/survey_items/destroy'
  	end
  
  	def delete
  		@item = @survey.items.find(params[:item_id])
	  	@item.update_attributes(:deleted_at => Time.now)
	  	render nothing: true, status: 200
  	end  	

  	def copy
  		@item = @survey.items.find(params[:item_id])
	  	@new_item = SurveyItem.new(@item.attributes.merge(previous_item_id: params[:previous_item_id]))

	  	if @new_item.save
	  		@new_item = SurveyItem.find(@new_item.id)
			render(partial: "survey_items/items/#{@item.type.demodulize.underscore}", locals:{item: @new_item})
		else
			render js: "alert('error')", status: :unprocessible_entry
		end
  	end
	
	private

	def get_survey
		@survey = Survey.demo_surveys.find(params[:survey_id])
	end
end
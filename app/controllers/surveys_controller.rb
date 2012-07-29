class SurveysController < ApplicationController
  def builder
    @survey = Survey.find(params[:id], :include => :items)
  end
  
  def	create
  	@survey = Survey.new(params[:survey])
  	if @survey.save
  	  redirect_to edit_survey_path(@survey, step: 'look_and_feel')
	  else
	    render action: :new
    end
  end
  
  def update
    @survey = Survey.find(params[:id])
    if @survey.update_attributes(params[:survey])
      @step = Survey::STEPS[Survey::STEPS.index(params[:step])+1] if Survey::STEPS.include?(params[:step])
      render action: :edit
    else
      render nothing: true, status: 403
    end
  end
  
  def new
    @survey = Survey.new
  end
  
  def edit
    @step = params[:step] || 'basic_info'
    @survey = Survey.find(params[:id])
  end
  
end


class SurveysController < ApplicationController
  def builder
    @survey = Survey.find(params[:id], :include => :items)
  end
  
  def index
    @surveys = Survey.all
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
    # render text: params.inspect and return
    @survey = Survey.find(params[:id])
    if @survey.update_attributes(params[:survey])
      if request.xhr?
        render nothing: true, status: 200
      else
        @step = Survey::STEPS[Survey::STEPS.index(params[:step])+1] if Survey::STEPS.include?(params[:step])
        redirect_to @step == 'builder' ? [:builder, @survey] : edit_survey_path(@survey, step: @step)
      end
    else
      render nothing: true, status: 400
    end
  end
  
  def new
    @survey = Survey.new
  end
  
  def show
    @survey = Survey.find(params[:id], :include => :items)
  end
  
  def edit
    @step = params[:step] || 'basic_info'
    @survey = Survey.find(params[:id])
  end

  def deploy
    @survey = Survey.find(params[:id])
  end
  
end


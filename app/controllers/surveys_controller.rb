class SurveysController < ApplicationController
  def builder
    @survey = current_account.surveys.find(params[:id], :include => :items)
  end
  
  def index
    @surveys = current_account.surveys
  end
  
  def	create
  	@survey = current_user.surveys.new(params[:survey].merge(account: current_account))
  	if @survey.save
  	  redirect_to builder_survey_path(@survey)
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
        flash[:notice] = "Changes saved"
        redirect_to @survey
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

  def trashbox
    @survey = Survey.find(params[:id])
    @trashed_items = @survey.items.trashed
    render layout: false
  end

  def responses
    @survey = Survey.find(params[:id])
    @responses = @survey.responses.order('created_at DESC')
  end
  
end


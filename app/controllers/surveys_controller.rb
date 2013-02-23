class SurveysController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_survey, only: [:update, :destroy, :edit, :deploy, :trashbox, :report, :switch]

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
    if @survey.update_attributes(params[:survey])
      if request.xhr?
        render nothing: true, status: 200
      else
        flash[:notice] = "Changes saved"
        redirect_to [:edit, @survey]
      end
    else
      render nothing: true, status: 400
    end
  end

  def destroy
    @survey.destroy
    redirect_to action: :index
  end

  def switch
    @survey.update_attributes(active: !@survey.active)
    render json: {active: @survey.active}.to_json
  end
  
  def new
    @survey = Survey.new
  end
  
  def edit
  end

  def deploy
  end

  def trashbox
    @trashed_items = @survey.items.trashed
    render layout: false
  end

  def report
    @responses_content = @survey.responses.map(&:content)
  end

  private

  def get_survey
    @survey = current_account.surveys.find(params[:id])
  end
  
end


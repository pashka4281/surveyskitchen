class SurveysController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_survey, except: [:create, :index, :new]

  def builder
    @themes_current = current_account.survey_themes
    @themes_global  = SurveyTheme.global
    @survey         = current_account.surveys.find(params[:id], :include => :items)
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
        redirect_to survey_themes_path(@survey) and return if params[:survey][:theme_id]
        redirect_to [:edit, @survey]
      end
    else
      render nothing: true, status: 400
    end
  end

  def look
    @my_themes = current_account.survey_themes.reject(&:new_record?)
    @theme = params[:theme_id] ? current_account.survey_themes.find(params[:theme_id]) : current_account.survey_themes.new
    @example_survey = Survey.preview_survey(current_user.language)
    @paged_items = @example_survey.paged_items
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

  def preview
    @paged_items = @survey.paged_items
    render layout: 'clients'
  end

  def share
  end

  def trashbox
    @trashed_items = @survey.items.trashed
    render layout: false
  end

  def report
    @options_colors = SURVEY_REPORT_SETTINGS['colors']['report_options']
    @responses_content = @survey.responses.map(&:content)
  end

  private

  def get_survey
    @survey = current_account.surveys.find(params[:id])
  end
  
end


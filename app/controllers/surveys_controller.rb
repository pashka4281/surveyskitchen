class SurveysController < ApplicationController
  def builder
    @survey = Survey.find(params[:id], :include => :items)
  end
  
  def	create
  	render js: 'ok'
  end
  
  def update
    @survey = Survey.find(params[:id])
    if @survey.update_attributes(params[:survey])
      render nothing: true, status: 200
    else
      render nothing: true, status: 403
    end
  end
  
end


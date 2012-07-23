class SurveysController < ApplicationController
  def builder
    @survey = Survey.find(params[:id], :include => :items)
  end
  
  def	create
  	render js: 'ok'
  end
  
end


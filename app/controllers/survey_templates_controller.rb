class SurveyTemplatesController < ApplicationController
  def index
    @templates = SurveyTemplate.all
  end
  def show # shows the HTML form
    @fields = SurveyTemplate.find(params[:id]).survey_fields
    @id = params[:id]
    @survey_title = SurveyTemplate.find(params[:id]).survey_title
    @survey_description = SurveyTemplate.find(params[:id]).survey_description
  end

end


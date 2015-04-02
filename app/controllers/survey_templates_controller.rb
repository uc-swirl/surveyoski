class SurveyTemplatesController < ApplicationController
  before_filter :authorize , :only => :show
  def authorize
      if not current_user
        session[:template_id] = params[:id]
        redirect_to "/auth/google_oauth2"
      end
  end

  def index
    @templates = SurveyTemplate.all
  end
  def show # shows the HTML form
  	template = SurveyTemplate.find(params[:id])
    @fields = template.survey_fields
    @id = params[:id]
    @survey_title = template.survey_title
    @survey_description = template.survey_description
  end
  def all_responses
  	@survey_template = SurveyTemplate.find(params[:id])
  end
  def participants
  	@survey_template = SurveyTemplate.find(params[:id])
  end

end


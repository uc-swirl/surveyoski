class SurveyTemplatesController < ApplicationController
  before_filter :authorize , :only => :show

  def new
    if not session[:survey]
      @survey = SurveyTemplate.new()
    else 
      @survey = session[:survey]
    end
    @fields = @survey.survey_fields
    @fields_types = 

    
    session[:survey] = @survey
  end

  def create
    if params[:commit] == 'Add Field'
      @survey = session[:survey]

      field_name = params[:new_field_name]
      field_type = params[:new_field_type]

      @survey.survey_fields << TextQuestionField.new(:question_title => field_name)

      return redirect_to new_survey_template_path
    end
  end

  def authorize
      session[:param] = "this is a parameter and it's in the session hash"
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

end


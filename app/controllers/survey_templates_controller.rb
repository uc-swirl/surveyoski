class SurveyTemplatesController < ApplicationController
  before_filter :authorize , :only => :show

  def new
    @field_types = SurveyField.descendants.map {|klass| klass.nice_name}
    
  end

  def create
    @survey = SurveyTemplate.create()
    @name = params[:form_name]
    @fields = params[:fields]
    name_to_type = Hash[SurveyField.descendants.map {|klass| [klass.nice_name, klass]}]


    @fields.each do |key, field_parm| 
      field_name = field_parm[:name]
      field_type = field_parm[:type]
      klass = name_to_type[field_type]
      field =  klass.new(:question_title => field_name)
      @survey.survey_fields << field
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


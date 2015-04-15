class SurveyTemplatesController < ApplicationController
  before_filter :authorize_user

  def authorize_user
      if not current_user
        session[:template_id] = params[:id]
        redirect_to "/auth/google_oauth2"
      end
  end

  def new
    authorize :survey_templates, :new?
    @field_types = SurveyField.descendants.map {|klass| klass.nice_name}
  end

  def edit
    authorize :survey_templates, :edit?
    @survey = SurveyTemplate.find(params[:id])
    @field_types = SurveyField.descendants.map {|klass| klass.nice_name}
    @fields_json = ActiveSupport::JSON.encode(@survey.survey_fields)
    render :new
  end

  def create
    @survey = SurveyTemplate.find_or_create_by_id(params[:id])
    @name = if params[:form_name]!='' then params[:form_name] else "Untitled("+@survey.created_at.to_s+")" end 
    @fields = if params[:fields] then params[:fields] else [] end
    name_to_type = Hash[SurveyField.descendants.map {|klass| [klass.nice_name, klass]}]
    @survey.survey_title = @name
    @survey.survey_fields = []
    @fields.each do |key, field_param| 
      klass = name_to_type[field_param[:type]]
      field =  klass.new(:question_title => field_param[:name], :question_weight => field_param[:weight])
      field.parse_options field_param[:options]
      @survey.survey_fields << field
    end
    @survey.save
    redirect_to survey_templates_path
  end

  def clone
    template = SurveyTemplate.find(params[:id])
    new_template = template.dup
    new_template.save
    amend_title(new_template)
    clone_fields(new_template, template)
    redirect_to survey_templates_path
  end

  def amend_title(clone)
    if clone.survey_title == nil
      clone.survey_title = "<no title> cloned"
    else
      clone.survey_title = clone.survey_title + " (cloned)"
    end
    clone.save
  end
  def clone_fields(clone, orig)
    orig.survey_fields.each do |field|
      clone.survey_fields << field.dup
    end
    clone.save
  end
  def clone_options(clone, field)
  end
  
  def index
    authorize :survey_templates, :index?
    @templates = SurveyTemplate.all
  end
  
  def show # shows the HTML form
    authorize :survey_templates, :show?
  	template = SurveyTemplate.find(params[:id])
    @fields = template.survey_fields
    @id = params[:id]
    @survey_title = template.survey_title
    @survey_description = template.survey_description
    render :layout => false
  end
  def all_responses
    authorize :survey_templates, :all_responses?
  	@survey_template = SurveyTemplate.find(params[:id])
  end
  def participants
    authorize :survey_templates, :participants?
  	@survey_template = SurveyTemplate.find(params[:id])
  end

  def destroy
    authorize :survey_templates, :destroy?
    @survey_template = SurveyTemplate.find(params[:id])
    @survey_template.destroy    
    redirect_to survey_templates_path
  end

end


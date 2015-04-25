class SurveyTemplatesController < ApplicationController
  before_filter :authorize_user

  def authorize_user
      if not current_user
        session[:template_id] = params[:id]
        redirect_to "/auth/google_oauth2"
      end
  end

  def status
      @survey = SurveyTemplate.find_by_uuid(params[:id]) #why does this not work with uuid
      render :text =>  @survey.status
  end

def update_status
    @survey = SurveyTemplate.find_by_uuid(params[:id]) #why does this not work with uuid
    @survey.status = params[:status]
    @survey.save! 
    render :text =>  @survey.status
end

  def new
    authorize :survey_templates, :new?
    @field_types = SurveyField.descendants.map {|klass| klass.nice_name}
    @courses = current_user.courses
    @title = "Create a new survey"
  end

  def edit
    @survey = SurveyTemplate.find_by_uuid(params[:id]) #why does this not work with uuid
    authorize @survey, :edit?
    @field_types = SurveyField.descendants.map {|klass| klass.nice_name}
    @fields_json = ActiveSupport::JSON.encode(@survey.survey_fields)
    @courses = current_user.courses
    @title = "Edit survey"
    render :new
  end

  def create
    @survey = SurveyTemplate.find_or_create_by_uuid(params[:id])
    @name = create_name
    @fields = if params[:fields] then params[:fields] else [] end
    attach_survey_basic
    attach_survey_fields
    @survey.save
    redirect_to survey_templates_path
  end

  def attach_survey_basic
    @survey.survey_title = @name
    @survey.survey_fields = []
    @survey.course = Course.find_by_id(params[:course_id])
    @survey.user_id ||= current_user.id
  end

  def create_name
    if params[:form_name]!='' then params[:form_name] else 'Untitled('+@survey.created_at.to_s+')' end
  end

  def attach_survey_fields
    name_to_type = Hash[SurveyField.descendants.map {|klass| [klass.nice_name, klass]}]
    @fields.each do |key, field_param|
      klass = name_to_type[field_param[:type]]
      field =  klass.find_or_create_by_id(field_param[:id] )
      field.update_attributes(:question_title => field_param[:name], :question_weight => field_param[:weight], :required => field_param[:required])
      field.parse_options field_param[:options]
      @survey.survey_fields << field
    end
  end

  def clone
    template = SurveyTemplate.find_by_uuid(params[:id])
    new_template = template.dup
    new_template.status = nil
    new_template.uuid = nil
    course = Course.find_by_name(params[:course_name])
    course.survey_templates << new_template
    new_template.save!
    amend_title(new_template)
    clone_fields(new_template, template)
    flash[:notice] = "Your course was cloned successfully. "
    flash.keep(:notice)
    render js: "window.location = '#{survey_templates_path}'"
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
  def index
    authorize :survey_templates, :index?
    @courses = current_user.courses
    #params[:page] ||= 1
    @templates = SurveyTemplate.sort(params[:sort], current_user, params[:page])
  end
  
  def show # shows the HTML form

    template = SurveyTemplate.find_by_uuid(params[:id]) #why does this not work with uuid
    authorize template
    @fields = template.survey_fields.sort_by {|field| field.question_weight}

    @id = params[:id] 
    @survey_title = template.survey_title
    @survey_description = template.survey_description
    @author = template.user.name ? template.user.name  : ""
    render :layout => false
  end
  def all_responses
    authorize :survey_templates, :all_responses?
    @survey_template = SurveyTemplate.find_by_uuid(params[:id]) #why does this not work with uuid
    if @survey_template.status != "closed"
      flash[:notice] = "You cannot see responses until your survey is closed."
      redirect_to survey_templates_path
    elsif @survey_template.submissions.length <= 10
      flash[:notice] = @survey_template.few_responses_message
      redirect_to survey_templates_path
    else
      @questions = @survey_template.titles_to_array
      @submissions = @survey_template.submissions_to_array #shuffle them inside the model, this is just embedded array of strings
    end
  end
  def participants
    authorize :survey_templates, :participants?
    @survey_template = SurveyTemplate.find_by_uuid(params[:id])
    @emails = @survey_template.get_participants
  end

  def download_data
    authorize :survey_templates, :all_responses?
    authorize :survey_templates, :participants?
    @survey_template = SurveyTemplate.find_by_uuid(params[:id])
    if params[:type] == 'submissions'
      data = @survey_template.submissions_to_csv
    else
      data = @survey_template.participants_to_csv
    end
    send_data data,
              filename: "#{@survey_template.survey_title} #{params[:type]}.csv",
              type: "application/csv"
  end

  def destroy
    authorize :survey_templates, :destroy?
    @survey_template = SurveyTemplate.find_by_uuid(params[:id])
    @survey_template.destroy    
    redirect_to survey_templates_path
  end

end


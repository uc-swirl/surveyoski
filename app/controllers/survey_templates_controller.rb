class SurveyTemplatesController < ApplicationController
  before_filter :authorize_user

  def authorize_user
      if not current_user
        session[:template_id] = params[:id]
        redirect_to "/auth/google_oauth2"
      end
  end

  def status
      puts "ID ", params[:id]
      @survey = SurveyTemplate.find(params[:id])
      puts @survey.status
      render :text =>  @survey.status
  end

def update_status
    @survey = SurveyTemplate.find(params[:id])
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
    authorize :survey_templates, :edit?
    @survey = SurveyTemplate.find(params[:id])
    @field_types = SurveyField.descendants.map {|klass| klass.nice_name}
    @fields_json = ActiveSupport::JSON.encode(@survey.survey_fields)
    @courses = current_user.courses
    @title = "Edit survey"
    render :new
  end

  def create
    @survey = SurveyTemplate.find_or_create_by_id(params[:id])
    @name = if params[:form_name]!='' then params[:form_name] else "Untitled("+@survey.created_at.to_s+")" end 
    @fields = if params[:fields] then params[:fields] else [] end
    name_to_type = Hash[SurveyField.descendants.map {|klass| [klass.nice_name, klass]}]
    @survey.survey_title = @name
    @survey.survey_fields = []
    @survey.course = Course.find_by_id(params[:course_id])
    @fields.each do |key, field_param| 
      klass = name_to_type[field_param[:type]]
      field =  klass.find_or_create_by_id(field_param[:id] )
      field.update_attributes(:question_title => field_param[:name], :question_weight => field_param[:weight], :required => field_param[:required])
      field.parse_options field_param[:options]
      @survey.survey_fields << field
    end
    @survey.user_id ||= current_user.id
    @survey.save
    redirect_to survey_templates_path
  end

  def clone
    # puts "cloning a survey!"
    template = SurveyTemplate.find(params[:id])
    new_template = template.dup
    new_template.status = nil
    course = Course.find_by_name(params[:course_name])
    course.survey_templates << new_template
    new_template.save!
    amend_title(new_template)
    clone_fields(new_template, template)
    flash[:notice] = "Your course was cloned successfully. "
    flash.keep(:notice)
    render js: "window.location = '#{survey_templates_path}'"
    # puts "finished cloning"
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
    @templates = SurveyTemplate.sort(params[:sort], current_user)
  end
  
  def show # shows the HTML form
    authorize :survey_templates, :show?
  	template = SurveyTemplate.find(params[:id])
    @fields = template.survey_fields.sort_by {|field| field.question_weight}
    @id = params[:id]
    @survey_title = template.survey_title
    @survey_description = template.survey_description
    @author = template.user.name
    render :layout => false
  end
  def all_responses
    authorize :survey_templates, :all_responses?
  	@survey_template = SurveyTemplate.find(params[:id])
    if @survey_template.status != "closed"
      flash[:notice] = "You cannot see responses until your survey is closed."
      redirect_to survey_templates_path
    end
    if @survey_template.submissions.length <= 10
      flash[:notice] = @survey_template.few_responses_message
      redirect_to survey_templates_path
    else
      @questions = @survey_template.titles_to_array
      @submissions = @survey_template.submissions_to_array #shuffle them inside the model, this is just embedded array of strings
    end
  end
  def participants
    authorize :survey_templates, :participants?
  	@survey_template = SurveyTemplate.find(params[:id])
    @emails = @survey_template.get_participants
  end

  def download_submissions
    authorize :survey_templates, :all_responses?
    @survey_template = SurveyTemplate.find(params[:id])
    send_data @survey_template.submissions_to_csv,
              filename: "#{@survey_template.survey_title}.csv",
              type: "application/csv"
  end

  def download_participants
    authorize :survey_templates, :all_responses?
    @survey_template = SurveyTemplate.find(params[:id])
    send_data @survey_template.participants_to_csv,
              filename: "#{@survey_template.survey_title}_participants.csv",
              type: "application/csv"
  end

  def destroy
    authorize :survey_templates, :destroy?
    @survey_template = SurveyTemplate.find(params[:id])
    @survey_template.destroy    
    redirect_to survey_templates_path
  end

end


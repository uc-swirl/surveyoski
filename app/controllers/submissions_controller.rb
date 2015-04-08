class SubmissionsController < ApplicationController
  def index
  end
  def new
  end
  def create
    user = User.find(session[:user_id])
    template = SurveyTemplate.find(params[:template_id])
    begin
      all_blank = params[:submission].keys.all? do |key|
        params[:submission][key] == ''
      end
      if all_blank
        raise "You need to at least fill out one field!"
      end

      participant = template.participants.build(:email => user.email)
      participant.save!

      submission = Submission.new
      template.submissions << submission
      params[:submission].each_key do |key|
        field = SurveyField.find(key)
        answer = field.field_responses.build(:response => params[:submission][key])
        answer.save!
        submission.field_responses << answer
        answer.save!
      end
      flash[:notice] = "Your submission was recorded."
      redirect_to survey_template_path(template.id)
    rescue Exception => e
      flash[:notice] = e.message
      redirect_to survey_template_path(template.id)
    end

  end 
end



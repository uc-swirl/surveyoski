class SubmissionsController < ApplicationController
  def index
  end
  def new
  end
  def create
    user = current_user
    template = SurveyTemplate.find_by_uuid(params[:template_id])
    begin
      # puts "template is nil? #{template == nil}"
      participant = template.participants.build(:email => user.email)
      participant.save! 
      # puts "don't get here i suppose"
      submission = Submission.create
      template.submissions << submission
      params[:submission].each_key do |key|
        field = SurveyField.find(key)
        answer = field.field_responses.build(:response => params[:submission][key])
        answer.save!
        submission.field_responses << answer
        answer.save!
      end
      flash[:notice] = "Your submission was recorded."
      redirect_to survey_template_path(template)
    rescue Exception => e
      # puts "participant is nil? #{participant == nil}"
      participant.destroy
      if submission
        submission.destroy
      end
      flash[:notice] = e.message.split(":")[-1]
      redirect_to survey_template_path(template)
    end

  end 
end

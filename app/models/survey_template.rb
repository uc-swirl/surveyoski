require 'csv'

class SurveyTemplate < ActiveRecord::Base
  attr_accessible :survey_title, :survey_description
  has_many :survey_fields
  has_many :checkbox_fields
  has_many :phone_fields
  has_many :drop_down_fields
  has_many :text_question_fields
  has_many :radio_button_fields
  has_many :email_fields
  has_many :submissions
  has_many :participants

  # this returns a csv in string format of: "QUESTION1,QUESTION2\NREPLY1A,REPLY1B\NREPLY2A,REPLY2B\N"
  # ex: "what is your favorite color?,do you like ponies?\nblue,maybe\nmagenta,no\n" 
  def get_all_responses
    titles = []
    survey_fields.each do |field|
      titles << field.question_title #IS THIS ORDER ALWAYS THE SAME??
    end
    output = titles.to_csv
    submissions.each do |submission|
      curr_submission = []
      survey_fields.each do |field|
        curr_submission << submission.field_responses.where(survey_field_id: field.id)[0].response
      end
      output += curr_submission.to_csv
    end
    output
  end

  # returns string in format of: "Student Email\nstudent1@berkeley.edu\nstudent2@berkeley.edu"
  # requires Participant Object to be instantiated when survey first submitted
  def get_participants
    emails = []
    participants.each do |response| 
      emails << response.email
    end
    ["Student Email"].to_csv + emails.to_csv
  end

end

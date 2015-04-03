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

  # this returns a csv in string format of: 
  # "what is your favorite color?,do you like ponies?\nblue,maybe\nmagenta,no\n"
  def get_all_responses
    if submissions.length == 0
  	  return "There have been no submissions yet."
    elsif submissions.length == 1
  	  return "There has only been one submission so far."
    elsif submissions.length <= 10
      return "There have only been #{number_to_name(submissions.length)} submissions so far."
    end

    titles = []
    survey_fields.each { |f| titles << f.question_title} #IS THIS ORDER ALWAYS THE SAME??
    output = titles.to_csv

    all_responses = []
    submissions.each do |s|
      curr_submis = []
      survey_fields.each do |f|
        curr_submis << s.field_responses.where(survey_field_id: f.id)[0].response
      end
      all_responses << curr_submis
    end

    all_responses.shuffle.each {|r| output += r.to_csv}
    output
  end

  # returns string in format of: "Student Email\nstudent1@berkeley.edu\nstudent2@berkeley.edu"
  # requires Participant Object to be instantiated when survey first submitted
  def get_participants
    emails = ["Student Email"].to_csv
    participants.each do |response| 
      emails += [response.email].to_csv
    end
    emails
  end

  def number_to_name(num)
    conversion  = {1 => "one", 2 => "two", 3 => "three", 4 => "four", 5 => "five", 
                   6 => "six", 7 => "seven", 8 => "eight", 9 => "nine", 10 => "ten"}
    conversion[num]
  end

  private :number_to_name

end

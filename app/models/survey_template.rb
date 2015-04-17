require 'csv'

class SurveyTemplate < ActiveRecord::Base
  attr_accessible :survey_title, :survey_description, :published, :author
  has_many :survey_fields , :dependent => :destroy
  has_many :checkbox_fields
  has_many :phone_fields
  has_many :drop_down_fields
  has_many :text_question_fields
  has_many :radio_button_fields
  has_many :email_fields
  has_many :submissions, :dependent => :destroy
  has_many :participants, :dependent => :destroy

  def submissions_to_csv
    if submissions.length <= 10
      return few_responses_message
    end
    output = titles_to_array.to_csv
    submissions_to_array.shuffle.each {|r| output += r.to_csv}
    output
  end

  def get_participants
    emails = ["Student Email"].to_csv
    participants.each do |response| 
      emails += [response.email].to_csv
    end
    emails
  end

  def few_responses_message
    if submissions.length == 0
      return "There have been no submissions yet."
    elsif submissions.length == 1
      return "There has only been one submission so far."
    elsif submissions.length <= 10
      return "There have only been #{number_to_name(submissions.length)} submissions so far."
    end
  end

  def titles_to_array
    titles = []
    survey_fields.each { |f| titles << f.question_title}
    titles
  end

  def submissions_to_array
    all_responses = []
    submissions.each do |s|
      curr_submis = []
      survey_fields.each do |f|
        field = s.field_responses.where(survey_field_id: f.id).first
        if field
          curr_submis << field.response
        else
          curr_submis << nil
        end
      end
      all_responses << curr_submis
    end
    all_responses.shuffle
  end

  def number_to_name(num)
    conversion  = {1 => "one", 2 => "two", 3 => "three", 4 => "four", 5 => "five", 
                   6 => "six", 7 => "seven", 8 => "eight", 9 => "nine", 10 => "ten"}
    conversion[num]
  end

  private :number_to_name

end

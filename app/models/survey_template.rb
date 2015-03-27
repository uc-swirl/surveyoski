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

end

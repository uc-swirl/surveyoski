class Submission < ActiveRecord::Base
  has_many :field_responses, dependent: :destroy
  belongs_to :survey_template
  
  
end

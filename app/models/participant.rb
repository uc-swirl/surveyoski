class Participant < ActiveRecord::Base
  attr_accessible :email
  belongs_to :survey_template
end
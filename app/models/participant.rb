class Participant < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :email
  belongs_to :survey_template
  validates :email, uniqueness: {scope: :survey_template_id, message: "You have already responded to a survey"}

end

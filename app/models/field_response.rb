class FieldResponse < ActiveRecord::Base
  attr_accessible :response
  belongs_to :survey_field
  belongs_to :submission

  validate :response_format

  def response_format
    if self.survey_field.required? and self.response == ""
      errors.add(:field_response, "You have not filled out all the required fields.")
    end
  end

end

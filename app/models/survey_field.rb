class SurveyField < ActiveRecord::Base
  attr_accessible :question_title, :question_description
  belongs_to :survey_template
  has_many :field_responses
  def is_valid? (response)
    {:value => true}
  end

  def self.descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end

  def edit_partial
    throw raise "edit partial not implemented"
  end

  def parse_options
    true
  end


  def self.nice_name
    throw raise "nice_name not implemented"
  end

end

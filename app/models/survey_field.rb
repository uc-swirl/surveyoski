class SurveyField < ActiveRecord::Base
  attr_accessible :question_title, :question_description
  belongs_to :survey_template
  has_many :field_responses
  serialize :field_options, JSON

  def is_valid? (response)
    {:value => true}
  end

  def self.descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end

  def edit_partial
    throw raise "edit partial not implemented"
  end

  def parse_options (options)
    true
  end

  def as_json(options = {})
    super({:root => false, methods: :nice_name}.merge(options || {}))
  end

  def self.nice_name
    throw raise "nice_name not implemented"
  end
  def nice_name
    self.class.nice_name
  end
end

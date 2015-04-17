class SurveyField < ActiveRecord::Base
  attr_accessible :question_title, :question_description, :question_weight
  belongs_to :survey_template
  has_many :field_responses, :dependent => :destroy
  serialize :field_options, JSON

  # def is_valid? (response)
  #   {:value => true}
  # end

  def self.descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end

  #input : {"1"=>{"name"=>"one1", "value"=>"1"}, "2"=>{"name"=>"two2", "value"=>"2"}}
  #set self.field_options : [["one1", "1"]. ["two2", "2"]]
  def parse_options (options)
    if options.kind_of?(Hash)
      self.field_options = options.values.map { |x| [x[:name], x[:value]]}
    end
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

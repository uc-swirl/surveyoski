class FixSurveyField < ActiveRecord::Migration
  def change
    add_column :survey_fields, :question_description, :string
  end
end

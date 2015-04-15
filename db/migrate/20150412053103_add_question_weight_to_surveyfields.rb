class AddQuestionWeightToSurveyfields < ActiveRecord::Migration
  def change
    add_column :survey_fields, :question_weight, :float
  end
end

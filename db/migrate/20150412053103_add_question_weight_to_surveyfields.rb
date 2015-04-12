class AddQuestionWeightToSurveyfields < ActiveRecord::Migration
  def change
    add_column :survey_fields, :question_wieght, :float
  end
end

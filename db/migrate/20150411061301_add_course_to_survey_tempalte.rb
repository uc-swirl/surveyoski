class AddCourseToSurveyTempalte < ActiveRecord::Migration
  def change
  	add_column :survey_templates, :course_id, :integer
  	add_index :survey_templates, :course_id
  end
end

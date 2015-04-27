class RescindingThatFix < ActiveRecord::Migration
  def up
    add_column :courses, :year, :string
  	add_column :courses, :department, :string
  	add_column :courses, :semester, :string
  	remove_column :survey_templates, :year
  	remove_column :survey_templates, :department
  	remove_column :survey_templates, :semester
  end

end

class RescindingThatFix < ActiveRecord::Migration
  def up
    add_column :courses, :year, :string
  	add_column :courses, :department, :string
  	add_column :courses, :semester, :string
  	remove_column :survey_templates, :year, :string
  	remove_column :survey_templates, :department, :string
  	remove_column :survey_templates, :semester, :string
  end

end

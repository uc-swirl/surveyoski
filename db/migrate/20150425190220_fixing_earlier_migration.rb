class FixingEarlierMigration < ActiveRecord::Migration
  def up
  	remove_column :courses, :year
  	remove_column :courses, :department
  	remove_column :courses, :semester
  	add_column :survey_templates, :year, :string
  	add_column :survey_templates, :department, :string
  	add_column :survey_templates, :semester, :string
  end


end

class FixingEarlierMigration < ActiveRecord::Migration
  def up
  	remove_column :courses, :year, :string
  	remove_column :courses, :department, :string
  	remove_column :courses, :semester, :string
  	add_column :survey_templates, :year, :string
  	add_column :survey_templates, :department, :string
  	add_column :survey_templates, :semester, :string
  end


end

class ChangePublicToPublicSurvey < ActiveRecord::Migration
  def up
  	remove_column :survey_templates, :public, :boolean
  	add_column :survey_templates, :public_survey, :boolean
  end
end

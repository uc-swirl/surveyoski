class AddUuidToSurveyTemplate < ActiveRecord::Migration
  def change
  	add_column :survey_templates, :uuid, :string
  	add_index :survey_templates, :uuid, :unique => true
  end
end

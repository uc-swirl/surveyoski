class FixSurveyTemplates < ActiveRecord::Migration
  def change
  	drop_table :survey_templates
    create_table :survey_templates do |t|
      t.string :survey_title
      t.string :survey_description
      t.timestamps
  	end
  end
end

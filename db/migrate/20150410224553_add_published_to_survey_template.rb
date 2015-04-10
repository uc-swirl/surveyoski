class AddPublishedToSurveyTemplate < ActiveRecord::Migration
  def change
  	add_column :survey_templates, :published, :boolean
  end
end

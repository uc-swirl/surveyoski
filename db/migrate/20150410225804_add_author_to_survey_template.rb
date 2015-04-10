class AddAuthorToSurveyTemplate < ActiveRecord::Migration
  def change
  	add_column :survey_templates, :author, :string
  end
end

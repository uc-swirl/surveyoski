class AddUserToSurvey < ActiveRecord::Migration
  def change
  	add_column :survey_templates, :user_id, :integer
  	remove_column :survey_templates, :author
  end
end

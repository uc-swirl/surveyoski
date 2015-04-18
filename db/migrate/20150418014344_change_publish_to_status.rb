class ChangePublishToStatus < ActiveRecord::Migration
  def up
  	add_column :survey_templates, :status, :string
  	remove_column :survey_templates, :published
  end

  def down
  end
end

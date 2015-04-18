class PublishedToStatus < ActiveRecord::Migration
  def change
    add_column :survey_templates, :status, :string
    remove_column :survey_templates, :published

  end
end

class AddingPublicField < ActiveRecord::Migration
  def up
  	add_column :survey_templates, :public, :boolean
  end
end

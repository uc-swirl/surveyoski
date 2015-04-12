class AddRequiredToSurveyField < ActiveRecord::Migration
  def change
    add_column :survey_fields, :required, :boolean

  end
end

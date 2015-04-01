class ReaddVariousOptionsToSurveyFields < ActiveRecord::Migration
  def change
    add_column :survey_fields, :drop_down_options, :string
    add_column :survey_fields, :checkbox_options, :string
    add_column :survey_fields, :radio_button_options, :string

  end
end

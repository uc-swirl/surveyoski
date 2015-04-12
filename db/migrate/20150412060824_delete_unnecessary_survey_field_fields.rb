class DeleteUnnecessarySurveyFieldFields < ActiveRecord::Migration
  def up
  	change_table(:survey_fields) do |t|
      t.remove :drop_down_options
      t.remove :checkbox_options
      t.remove :radio_button_options
  	end
  end

  def down
  end
end

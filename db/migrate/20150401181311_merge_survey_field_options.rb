class MergeSurveyFieldOptions < ActiveRecord::Migration
  def change
    drop_table :survey_fields
    create_table :survey_fields do |t|
      t.string :type
      t.references :survey_template
      t.string :question_title
      t.string :question_description
      t.string :field_options
      t.timestamps
    end
  end

end


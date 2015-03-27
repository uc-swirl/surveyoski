class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :email
      t.references :survey_template
      t.timestamps
    end
  end
end

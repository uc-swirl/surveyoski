class AddNameToCourse < ActiveRecord::Migration
  def change
  	add_column :courses, :name, :string
  end
end

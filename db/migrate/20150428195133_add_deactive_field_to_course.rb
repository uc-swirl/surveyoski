class AddDeactiveFieldToCourse < ActiveRecord::Migration
  def change
  	add_column :courses, :active, :boolean
  end
end

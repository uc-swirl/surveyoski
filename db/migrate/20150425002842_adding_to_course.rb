class AddingToCourse < ActiveRecord::Migration
  def up
  	add_column :courses, :year, :string
  	add_column :courses, :department, :string
  	add_column :courses, :semester, :string
  end
end

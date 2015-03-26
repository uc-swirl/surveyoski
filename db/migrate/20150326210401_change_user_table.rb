class ChangeUserTable < ActiveRecord::Migration
  def up
  	if ActiveRecord::Base.connection.table_exists? :users
      drop_table :users
    end
    create_table :users do |t|
    	t.string :email
    	t.string :name
    	t.timestamps
    end

  end

  def down
  end
end

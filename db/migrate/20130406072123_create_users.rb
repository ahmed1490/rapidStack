class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
    	t.string :name, :null => false
     	t.string :email, :null => false
     	t.string :password, :limit => 10, :null => false
     	t.integer :usertype, :default => 1, :null => false

      	t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end

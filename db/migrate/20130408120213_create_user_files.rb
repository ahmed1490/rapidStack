class CreateUserFiles < ActiveRecord::Migration
  def self.up
    create_table :user_files do |t|
    	t.references :user
    	t.references :rapid_file
    	t.text :tags

    	t.timestamps
    end
    add_index :user_files, [ 'user_id', 'rapid_file_id' ]
  end

  def self.down
    drop_table :user_files
  end
end

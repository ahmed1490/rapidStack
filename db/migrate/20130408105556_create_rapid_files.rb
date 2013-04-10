class CreateRapidFiles < ActiveRecord::Migration
  def self.up
    create_table :rapid_files do |t|

		t.string :filename, :null => false
		t.string :filepath, :null => false
		t.boolean :public, :default => true

    	t.timestamps
    end
  end

  def self.down
    drop_table :rapid_files
  end
end

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130408120213) do

  create_table "rapid_files", :force => true do |t|
    t.string   "filename",                     :null => false
    t.string   "filepath",                     :null => false
    t.boolean  "public",     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_files", :force => true do |t|
    t.integer  "user_id"
    t.integer  "rapid_file_id"
    t.text     "tags"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_files", ["user_id", "rapid_file_id"], :name => "index_user_files_on_user_id_and_rapid_file_id"

  create_table "users", :force => true do |t|
    t.string   "name",                                    :null => false
    t.string   "email",                                   :null => false
    t.string   "password",   :limit => 10,                :null => false
    t.integer  "usertype",                 :default => 1, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_190_622_194_651) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'todo_items', force: :cascade do |t|
    t.integer 'todo_list_id'
    t.string 'content'
    t.datetime 'completed_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[todo_list_id content], name: 'index_todo_items_on_todo_list_id_and_content'
    t.index ['todo_list_id'], name: 'index_todo_items_on_todo_list_id'
  end

  create_table 'todo_lists', force: :cascade do |t|
    t.bigint 'user_id'
    t.string 'title'
    t.text 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[title description], name: 'index_todo_lists_on_title_and_description'
    t.index ['user_id'], name: 'index_todo_lists_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.string 'password_digest'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[name email], name: 'index_users_on_name_and_email', unique: true
  end

  add_foreign_key 'todo_items', 'todo_lists'
  add_foreign_key 'todo_lists', 'users'
end

# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20131031212036) do

  create_table "Users", :force => true do |t|
    t.string   "email"
    t.string   "password",   :limit => nil
    t.boolean  "godBit"
    t.string   "firstName"
    t.string   "lastName"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "calendar_items", :force => true do |t|
    t.integer  "actionItemID"
    t.text     "calendarText"
    t.date     "calendarDate"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "college_admins", :force => true do |t|
    t.integer  "userID"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "communications_users", :force => true do |t|
    t.integer  "userID"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "department_admins", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "faculty_profiles", :force => true do |t|
    t.text     "currentResearch"
    t.text     "eduction"
    t.text     "honors"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "faculty_users", :force => true do |t|
    t.integer  "userID"
    t.integer  "facultyPageID"
    t.integer  "userPictureID"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "news_items", :force => true do |t|
    t.integer  "actionItemID"
    t.text     "newsText"
    t.date     "newsDate"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "publications", :force => true do |t|
    t.integer  "facultyUserID"
    t.text     "publicationText"
    t.string   "phoneNumber"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "user_pictures", :force => true do |t|
    t.integer  "userID"
    t.string   "picturePath"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "user_types", :force => true do |t|
    t.integer  "userID"
    t.boolean  "isSuperUser"
    t.boolean  "isGenericUSer"
    t.boolean  "isFacultyUser"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

end

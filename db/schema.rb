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

ActiveRecord::Schema.define(:version => 20140407191712) do

  create_table "action_items", :force => true do |t|
    t.integer  "createdByID"
    t.boolean  "isApproved"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "itemType"
  end

  create_table "attachments", :force => true do |t|
    t.text     "description"
    t.string   "file"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "attachments", ["attachable_id"], :name => "index_attachments_on_attachable_id"

  create_table "calendar_items", :force => true do |t|
    t.integer  "actionItemID"
    t.text     "calendarText"
    t.date     "calendarDate"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "title"
  end

  create_table "centers", :force => true do |t|
    t.string   "name"
    t.integer  "cms_site_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "cms_blocks", :force => true do |t|
    t.integer  "page_id",                        :null => false
    t.string   "identifier",                     :null => false
    t.text     "content",    :limit => 16777215
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "cms_blocks", ["page_id", "identifier"], :name => "index_cms_blocks_on_page_id_and_identifier"

  create_table "cms_categories", :force => true do |t|
    t.integer "site_id",          :null => false
    t.string  "label",            :null => false
    t.string  "categorized_type", :null => false
  end

  add_index "cms_categories", ["site_id", "categorized_type", "label"], :name => "index_cms_categories_on_site_id_and_categorized_type_and_label", :unique => true

  create_table "cms_categorizations", :force => true do |t|
    t.integer "category_id",      :null => false
    t.string  "categorized_type", :null => false
    t.integer "categorized_id",   :null => false
  end

  add_index "cms_categorizations", ["category_id", "categorized_type", "categorized_id"], :name => "index_cms_categorizations_on_cat_id_and_catd_type_and_catd_id", :unique => true

  create_table "cms_files", :force => true do |t|
    t.integer  "site_id",                                          :null => false
    t.integer  "block_id"
    t.string   "label",                                            :null => false
    t.string   "file_file_name",                                   :null => false
    t.string   "file_content_type",                                :null => false
    t.integer  "file_file_size",                                   :null => false
    t.string   "description",       :limit => 2048
    t.integer  "position",                          :default => 0, :null => false
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  add_index "cms_files", ["site_id", "block_id"], :name => "index_cms_files_on_site_id_and_block_id"
  add_index "cms_files", ["site_id", "file_file_name"], :name => "index_cms_files_on_site_id_and_file_file_name"
  add_index "cms_files", ["site_id", "label"], :name => "index_cms_files_on_site_id_and_label"
  add_index "cms_files", ["site_id", "position"], :name => "index_cms_files_on_site_id_and_position"

  create_table "cms_layouts", :force => true do |t|
    t.integer  "site_id",                                           :null => false
    t.integer  "parent_id"
    t.string   "app_layout"
    t.string   "label",                                             :null => false
    t.string   "identifier",                                        :null => false
    t.text     "content",    :limit => 16777215
    t.text     "css",        :limit => 16777215
    t.text     "js",         :limit => 16777215
    t.integer  "position",                       :default => 0,     :null => false
    t.boolean  "is_shared",                      :default => false, :null => false
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
  end

  add_index "cms_layouts", ["parent_id", "position"], :name => "index_cms_layouts_on_parent_id_and_position"
  add_index "cms_layouts", ["site_id", "identifier"], :name => "index_cms_layouts_on_site_id_and_identifier", :unique => true

  create_table "cms_pages", :force => true do |t|
    t.integer  "site_id",                                               :null => false
    t.integer  "layout_id"
    t.integer  "parent_id"
    t.integer  "target_page_id"
    t.string   "label",                                                 :null => false
    t.string   "slug"
    t.string   "full_path",                                             :null => false
    t.text     "content",        :limit => 16777215
    t.integer  "position",                           :default => 0,     :null => false
    t.integer  "children_count",                     :default => 0,     :null => false
    t.boolean  "is_published",                       :default => true,  :null => false
    t.boolean  "is_shared",                          :default => false, :null => false
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
  end

  add_index "cms_pages", ["parent_id", "position"], :name => "index_cms_pages_on_parent_id_and_position"
  add_index "cms_pages", ["site_id", "full_path"], :name => "index_cms_pages_on_site_id_and_full_path"

  create_table "cms_revisions", :force => true do |t|
    t.string   "record_type",                     :null => false
    t.integer  "record_id",                       :null => false
    t.text     "data",        :limit => 16777215
    t.datetime "created_at"
  end

  add_index "cms_revisions", ["record_type", "record_id", "created_at"], :name => "index_cms_revisions_on_rtype_and_rid_and_created_at"

  create_table "cms_sites", :force => true do |t|
    t.string  "label",                          :null => false
    t.string  "identifier",                     :null => false
    t.string  "hostname",                       :null => false
    t.string  "path"
    t.string  "locale",      :default => "en",  :null => false
    t.boolean "is_mirrored", :default => false, :null => false
  end

  add_index "cms_sites", ["hostname"], :name => "index_cms_sites_on_hostname"
  add_index "cms_sites", ["is_mirrored"], :name => "index_cms_sites_on_is_mirrored"

  create_table "cms_snippets", :force => true do |t|
    t.integer  "site_id",                                           :null => false
    t.string   "label",                                             :null => false
    t.string   "identifier",                                        :null => false
    t.text     "content",    :limit => 16777215
    t.integer  "position",                       :default => 0,     :null => false
    t.boolean  "is_shared",                      :default => false, :null => false
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
  end

  add_index "cms_snippets", ["site_id", "identifier"], :name => "index_cms_snippets_on_site_id_and_identifier", :unique => true
  add_index "cms_snippets", ["site_id", "position"], :name => "index_cms_snippets_on_site_id_and_position"

  create_table "comments", :force => true do |t|
    t.integer  "owner_id",         :null => false
    t.integer  "commentable_id",   :null => false
    t.string   "commentable_type", :null => false
    t.text     "body",             :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "communications_users", :force => true do |t|
    t.integer  "userID"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "computer_program_associations", :force => true do |t|
    t.integer  "equipmentID"
    t.integer  "computerProgramID"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "computer_programs", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "publisher"
    t.string   "vendor"
    t.string   "serial"
    t.string   "license"
    t.integer  "licenseCount"
    t.datetime "expDate"
    t.string   "uaAccountNo"
    t.string   "installNotes"
    t.string   "testingNotes"
    t.string   "accountNotes"
    t.integer  "userID"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.boolean  "classroomImage"
    t.boolean  "econImage"
    t.boolean  "labImage"
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.integer  "cms_site_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "phone"
    t.string   "fax"
    t.string   "office"
    t.string   "building"
    t.string   "poBox"
  end

  create_table "equipment", :force => true do |t|
    t.integer  "locationID"
    t.string   "serial"
    t.integer  "status"
    t.integer  "departmentID"
    t.string   "description"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "ip"
    t.string   "type"
  end

  create_table "equipment_tasks", :id => false, :force => true do |t|
    t.integer "equipment_id"
    t.integer "task_id"
  end

  add_index "equipment_tasks", ["equipment_id", "task_id"], :name => "index_equipment_tasks_on_equipment_id_and_task_id"

  create_table "faculty_profiles", :force => true do |t|
    t.text     "currentResearch"
    t.text     "education"
    t.text     "honors"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "permalink"
  end

  create_table "faculty_users", :force => true do |t|
    t.integer  "userID"
    t.integer  "facultyProfileID"
    t.integer  "userPictureID"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "cms_site_id"
    t.boolean  "cms_site_enabled", :default => false
  end

  create_table "jobs", :force => true do |t|
    t.integer  "ticketID"
    t.string   "description"
    t.boolean  "completed",     :default => false
    t.integer  "completedByID"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "lab_tickets", :force => true do |t|
    t.integer  "locationID"
    t.integer  "programID"
    t.string   "problemDescription"
    t.integer  "status"
    t.datetime "dateScheduled"
    t.integer  "clientID"
    t.integer  "requestedBy"
    t.integer  "receivingTech"
    t.integer  "supervisorID"
    t.string   "techNotes"
    t.integer  "urgency"
    t.string   "resolution"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "closingTech"
    t.datetime "dateClosed"
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.string   "notes"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "monologue_posts", :force => true do |t|
    t.boolean  "published"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "user_id"
    t.string   "title"
    t.text     "content"
    t.string   "url"
    t.datetime "published_at"
  end

  add_index "monologue_posts", ["url"], :name => "index_monologue_posts_on_url", :unique => true

  create_table "monologue_taggings", :force => true do |t|
    t.integer "post_id"
    t.integer "tag_id"
  end

  add_index "monologue_taggings", ["post_id"], :name => "index_monologue_taggings_on_post_id"
  add_index "monologue_taggings", ["tag_id"], :name => "index_monologue_taggings_on_tag_id"

  create_table "monologue_tags", :force => true do |t|
    t.string "name"
  end

  add_index "monologue_tags", ["name"], :name => "index_monologue_tags_on_name"

  create_table "monologue_users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "news_items", :force => true do |t|
    t.integer  "actionItemID"
    t.text     "newsText"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "title"
    t.boolean  "blogged",      :default => false
  end

  create_table "printer_associations", :force => true do |t|
    t.integer  "equipmentID"
    t.integer  "printerID"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "programs", :force => true do |t|
    t.string   "name"
    t.integer  "cms_site_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "publications", :force => true do |t|
    t.integer  "facultyUserID"
    t.text     "publicationText"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "system_images", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tasks", :force => true do |t|
    t.integer  "labTicketID"
    t.string   "description"
    t.integer  "assignedTech"
    t.boolean  "completed"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.datetime "dateClosed"
    t.integer  "closingTech"
  end

  create_table "trouble_tickets", :force => true do |t|
    t.integer  "locationID"
    t.integer  "equipmentID"
    t.integer  "programID"
    t.string   "problemDescription"
    t.integer  "status"
    t.datetime "dateScheduled"
    t.integer  "clientID"
    t.integer  "requestedBy"
    t.integer  "receivingTech"
    t.integer  "assignedTech"
    t.boolean  "assignedTechConfirmed"
    t.integer  "supervisorID"
    t.datetime "dateClosed"
    t.string   "techNotes"
    t.integer  "urgency"
    t.string   "resolution"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "closingTech"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.boolean  "godBit"
    t.string   "firstName"
    t.string   "lastName"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "password_digest"
    t.boolean  "isSuperUser"
    t.boolean  "isGenericUser"
    t.boolean  "isFacultyUser"
    t.boolean  "isCommunicationsUser"
    t.string   "phoneNumber"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "isSupervisorUser"
    t.boolean  "isTechUser"
    t.boolean  "isClientUser"
    t.integer  "departmentID"
    t.integer  "locationID"
    t.integer  "taskPoints"
  end

  create_table "versions", :force => true do |t|
    t.integer  "versioned_id"
    t.string   "versioned_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "user_name"
    t.text     "modifications"
    t.integer  "number"
    t.integer  "reverted_from"
    t.string   "tag"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "versions", ["created_at"], :name => "index_versions_on_created_at"
  add_index "versions", ["number"], :name => "index_versions_on_number"
  add_index "versions", ["tag"], :name => "index_versions_on_tag"
  add_index "versions", ["user_id", "user_type"], :name => "index_versions_on_user_id_and_user_type"
  add_index "versions", ["user_name"], :name => "index_versions_on_user_name"
  add_index "versions", ["versioned_id", "versioned_type"], :name => "index_versions_on_versioned_id_and_versioned_type"

end

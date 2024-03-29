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

ActiveRecord::Schema.define(:version => 20111117065934) do

  create_table "assets", :force => true do |t|
    t.string   "blob_file_name"
    t.string   "blob_content_type"
    t.integer  "blob_file_size"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assets", ["attachable_id", "attachable_type"], :name => "index_assets_on_attachable_id_and_attachable_type"

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "score",            :default => 0
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"

  create_table "order_addresses", :force => true do |t|
    t.integer  "order_id",      :null => false
    t.integer  "user_id",       :null => false
    t.string   "city"
    t.string   "street"
    t.string   "phone_number"
    t.string   "phone_number2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_lines", :force => true do |t|
    t.integer  "order_id",                                  :null => false
    t.integer  "product_id",                                :null => false
    t.decimal  "unit_price", :precision => 10, :scale => 2
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "optional"
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id",                                         :null => false
    t.datetime "shipped_on"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",           :limit => 2, :default => 0
    t.boolean  "include_delivery",              :default => true
  end

  create_table "products", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.decimal  "price",              :precision => 10, :scale => 2
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.integer  "product_id"
    t.text     "summary"
    t.integer  "position"
    t.boolean  "is_discontinued",                                   :default => false
    t.boolean  "is_producible",                                     :default => false
    t.boolean  "is_mixture",                                        :default => false
    t.boolean  "is_primary",                                        :default => false
    t.boolean  "is_default",                                        :default => false
    t.boolean  "is_commentable",                                    :default => true
    t.boolean  "numeric_sort",                                      :default => false
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin"
    t.string   "fullname"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "wiki_pages", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "slug"
    t.boolean  "is_visible", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

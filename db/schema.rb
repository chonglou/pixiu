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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150124051536) do

  create_table "attachments", force: :cascade do |t|
    t.integer  "user_id",      limit: 4,   null: false
    t.string   "title",        limit: 255, null: false
    t.string   "content_type", limit: 255, null: false
    t.string   "ext",          limit: 5,   null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "avatar",       limit: 255
  end

  add_index "attachments", ["content_type"], name: "index_attachments_on_content_type", using: :btree
  add_index "attachments", ["ext"], name: "index_attachments_on_ext", using: :btree
  add_index "attachments", ["title"], name: "index_attachments_on_title", using: :btree

  create_table "carts", force: :cascade do |t|
    t.string   "token",      limit: 36, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "carts", ["token"], name: "index_carts_on_token", using: :btree

  create_table "carts_products", id: false, force: :cascade do |t|
    t.integer "product_id", limit: 4
    t.integer "cart_id",    limit: 4
  end

  add_index "carts_products", ["cart_id"], name: "index_carts_products_on_cart_id", using: :btree
  add_index "carts_products", ["product_id"], name: "index_carts_products_on_product_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.string   "project_uid", limit: 32,    null: false
    t.string   "uid",         limit: 32,    null: false
    t.text     "content",     limit: 65535, null: false
    t.integer  "comment_id",  limit: 4
    t.integer  "order_id",    limit: 4,     null: false
    t.integer  "user_id",     limit: 4,     null: false
    t.integer  "star",        limit: 4,     null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "comments", ["project_uid"], name: "index_comments_on_project_uid", using: :btree
  add_index "comments", ["uid"], name: "index_comments_on_uid", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,     null: false
    t.string   "qq",         limit: 16
    t.string   "wechat",     limit: 32
    t.string   "fax",        limit: 16
    t.string   "phone",      limit: 16
    t.string   "email",      limit: 32
    t.string   "skype",      limit: 32
    t.string   "address",    limit: 255
    t.text     "details",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "documents", force: :cascade do |t|
    t.string   "name",       limit: 32,                      null: false
    t.string   "lang",       limit: 5,     default: "zh-CN", null: false
    t.string   "title",      limit: 64,                      null: false
    t.string   "summary",    limit: 255,                     null: false
    t.text     "body",       limit: 65535,                   null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "documents", ["name", "lang"], name: "index_documents_on_name_and_lang", unique: true, using: :btree

  create_table "documents_tags", id: false, force: :cascade do |t|
    t.integer "document_id", limit: 4, null: false
    t.integer "tag_id",      limit: 4, null: false
  end

  add_index "documents_tags", ["document_id"], name: "index_documents_tags_on_document_id", using: :btree
  add_index "documents_tags", ["tag_id"], name: "index_documents_tags_on_tag_id", using: :btree

  create_table "locales", force: :cascade do |t|
    t.integer "flag", limit: 2,  null: false
    t.string  "lang", limit: 5,  null: false
    t.string  "uid",  limit: 36, null: false
    t.integer "tid",  limit: 4,  null: false
  end

  add_index "locales", ["lang"], name: "index_locales_on_lang", using: :btree
  add_index "locales", ["uid"], name: "index_locales_on_uid", using: :btree

  create_table "notices", force: :cascade do |t|
    t.string   "lang",       limit: 5,   default: "zh-CN", null: false
    t.string   "content",    limit: 255,                   null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "notices", ["lang"], name: "index_notices_on_lang", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,              null: false
    t.string   "uid",        limit: 36,             null: false
    t.integer  "status",     limit: 4,  default: 0, null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "orders", ["uid"], name: "index_orders_on_uid", unique: true, using: :btree

  create_table "orders_products", id: false, force: :cascade do |t|
    t.integer "product_id", limit: 4
    t.integer "order_id",   limit: 4
  end

  add_index "orders_products", ["order_id"], name: "index_orders_products_on_order_id", using: :btree
  add_index "orders_products", ["product_id"], name: "index_orders_products_on_product_id", using: :btree

  create_table "prices", force: :cascade do |t|
    t.integer  "product_id", limit: 4,                                        null: false
    t.decimal  "value",                precision: 15, scale: 2, default: 0.0, null: false
    t.integer  "flag",       limit: 4,                          default: 0,   null: false
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "lang",       limit: 5,     default: "zh-CN", null: false
    t.string   "uid",        limit: 36,                      null: false
    t.string   "name",       limit: 255,                     null: false
    t.string   "summary",    limit: 255,                     null: false
    t.text     "details",    limit: 65535,                   null: false
    t.integer  "status",     limit: 4,     default: 0,       null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.text     "spec",       limit: 65535
    t.text     "pack",       limit: 65535
    t.text     "service",    limit: 65535
    t.boolean  "hot",        limit: 1,     default: false,   null: false
    t.boolean  "latest",     limit: 1,     default: false,   null: false
  end

  add_index "products", ["lang"], name: "index_products_on_lang", using: :btree
  add_index "products", ["uid"], name: "index_products_on_uid", unique: true, using: :btree

  create_table "products_tags", id: false, force: :cascade do |t|
    t.integer "product_id", limit: 4, null: false
    t.integer "tag_id",     limit: 4, null: false
  end

  add_index "products_tags", ["product_id"], name: "index_products_tags_on_product_id", using: :btree
  add_index "products_tags", ["tag_id"], name: "index_products_tags_on_tag_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "resource_id",   limit: 4
    t.string   "resource_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "samples", force: :cascade do |t|
    t.integer  "product_id",    limit: 4,                   null: false
    t.integer  "attachment_id", limit: 4,                   null: false
    t.string   "title",         limit: 255,                 null: false
    t.string   "summary",       limit: 500
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.boolean  "logo",          limit: 1,   default: false, null: false
  end

  create_table "settings", force: :cascade do |t|
    t.string   "var",        limit: 255,   null: false
    t.text     "value",      limit: 65535
    t.integer  "thing_id",   limit: 4
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name",       limit: 32,                   null: false
    t.string   "lang",       limit: 5,  default: "zh-CN", null: false
    t.integer  "parent_id",  limit: 4
    t.integer  "flag",       limit: 4,                    null: false
    t.string   "uid",        limit: 36,                   null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "tags", ["lang"], name: "index_tags_on_lang", using: :btree
  add_index "tags", ["name"], name: "index_tags_on_name", using: :btree
  add_index "tags", ["uid"], name: "index_tags_on_uid", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.integer  "failed_attempts",        limit: 4,   default: 0,  null: false
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",             limit: 32,               null: false
    t.string   "last_name",              limit: 32,               null: false
    t.string   "middle_name",            limit: 32
    t.string   "label",                  limit: 32,               null: false
    t.string   "uid",                    limit: 36,               null: false
    t.integer  "logo_id",                limit: 4
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["first_name", "last_name", "middle_name"], name: "index_users_on_first_name_and_last_name_and_middle_name", using: :btree
  add_index "users", ["label"], name: "index_users_on_label", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "role_id", limit: 4
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "visit_counters", force: :cascade do |t|
    t.integer "flag",  limit: 2,             null: false
    t.integer "key",   limit: 4,             null: false
    t.integer "count", limit: 4, default: 0, null: false
  end

end

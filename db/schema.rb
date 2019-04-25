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

ActiveRecord::Schema.define(version: 20190425133508) do

  create_table "applikations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.boolean  "cancel",      default: false, null: false
    t.datetime "canceled_at"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["project_id"], name: "index_applikations_on_project_id", using: :btree
    t.index ["user_id", "project_id"], name: "index_applikations_on_user_id_and_project_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_applikations_on_user_id", using: :btree
  end

  create_table "comment_to_projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "comment",    limit: 65535
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["project_id"], name: "index_comment_to_projects_on_project_id", using: :btree
    t.index ["user_id"], name: "index_comment_to_projects_on_user_id", using: :btree
  end

  create_table "project_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "project_favorites", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_favorites_on_project_id", using: :btree
    t.index ["user_id", "project_id"], name: "index_project_favorites_on_user_id_and_project_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_project_favorites_on_user_id", using: :btree
  end

  create_table "projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "content",             limit: 65535
    t.integer  "user_id"
    t.datetime "deadline"
    t.integer  "recruitment_numbers"
    t.boolean  "all_or_nothing",                    default: false, null: false
    t.boolean  "call_off",                          default: false, null: false
    t.integer  "project_category_id"
    t.string   "image"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.boolean  "set_the_maximum",                   default: false, null: false
    t.index ["project_category_id"], name: "index_projects_on_project_category_id", using: :btree
    t.index ["user_id"], name: "index_projects_on_user_id", using: :btree
  end

  create_table "universities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_relationships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "follow_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follow_id"], name: "index_user_relationships_on_follow_id", using: :btree
    t.index ["user_id", "follow_id"], name: "index_user_relationships_on_user_id_and_follow_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_user_relationships_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "image"
    t.text     "profile",         limit: 65535
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "university_id"
    t.index ["university_id"], name: "index_users_on_university_id", using: :btree
  end

  add_foreign_key "applikations", "projects"
  add_foreign_key "applikations", "users"
  add_foreign_key "comment_to_projects", "projects"
  add_foreign_key "comment_to_projects", "users"
  add_foreign_key "project_favorites", "projects"
  add_foreign_key "project_favorites", "users"
  add_foreign_key "projects", "project_categories"
  add_foreign_key "projects", "users"
  add_foreign_key "user_relationships", "users"
  add_foreign_key "user_relationships", "users", column: "follow_id"
  add_foreign_key "users", "universities"
end

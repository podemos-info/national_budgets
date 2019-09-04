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

ActiveRecord::Schema.define(version: 2019_09_04_215519) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "articles", force: :cascade do |t|
    t.integer "ref"
    t.string "title"
    t.bigint "chapter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chapter_id"], name: "index_articles_on_chapter_id"
  end

  create_table "budgets", force: :cascade do |t|
    t.string "title", null: false
    t.date "date", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chapters", force: :cascade do |t|
    t.integer "ref"
    t.string "title"
    t.bigint "budget_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["budget_id"], name: "index_chapters_on_budget_id"
  end

  create_table "concepts", force: :cascade do |t|
    t.integer "ref"
    t.string "title"
    t.bigint "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_concepts_on_article_id"
  end

  create_table "organisms", force: :cascade do |t|
    t.integer "ref"
    t.string "title"
    t.bigint "section_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["section_id"], name: "index_organisms_on_section_id"
  end

  create_table "programs", force: :cascade do |t|
    t.string "ref", null: false
    t.string "title", null: false
    t.bigint "section_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organism_id"
    t.index ["organism_id"], name: "index_programs_on_organism_id"
    t.index ["section_id"], name: "index_programs_on_section_id"
  end

  create_table "sections", force: :cascade do |t|
    t.integer "ref", null: false
    t.string "title", null: false
    t.bigint "budget_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["budget_id"], name: "index_sections_on_budget_id"
  end

  create_table "services", force: :cascade do |t|
    t.integer "ref", null: false
    t.string "title", null: false
    t.bigint "budget_id", null: false
    t.bigint "section_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["section_id"], name: "index_services_on_section_id"
  end

  create_table "subconcepts", force: :cascade do |t|
    t.integer "ref"
    t.string "title"
    t.bigint "concept_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["concept_id"], name: "index_subconcepts_on_concept_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "articles", "chapters"
  add_foreign_key "budgets", "users"
  add_foreign_key "chapters", "budgets"
  add_foreign_key "concepts", "articles"
  add_foreign_key "organisms", "sections"
  add_foreign_key "programs", "organisms"
  add_foreign_key "programs", "sections"
  add_foreign_key "sections", "budgets"
  add_foreign_key "services", "sections"
  add_foreign_key "subconcepts", "concepts"
end

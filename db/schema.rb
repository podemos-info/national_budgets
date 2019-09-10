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

ActiveRecord::Schema.define(version: 2019_09_06_065816) do

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

  create_table "amendments", force: :cascade do |t|
    t.string "number"
    t.string "type"
    t.text "explanation"
    t.bigint "user_id"
    t.bigint "budget_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["budget_id"], name: "index_amendments_on_budget_id"
    t.index ["user_id"], name: "index_amendments_on_user_id"
  end

  create_table "articles", force: :cascade do |t|
    t.integer "ref", null: false
    t.string "title", null: false
    t.bigint "chapter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chapter_id"], name: "index_articles_on_chapter_id"
  end

  create_table "articulateds", force: :cascade do |t|
    t.bigint "amendment_id", null: false
    t.string "type", null: false
    t.bigint "section_id", null: false
    t.string "title", null: false
    t.text "text", null: false
    t.text "justification", null: false
    t.string "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["amendment_id"], name: "index_articulateds_on_amendment_id"
    t.index ["section_id"], name: "index_articulateds_on_section_id"
  end

  create_table "budgets", force: :cascade do |t|
    t.string "title", null: false
    t.date "date", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chapters", force: :cascade do |t|
    t.integer "ref", null: false
    t.string "title", null: false
    t.bigint "budget_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["budget_id"], name: "index_chapters_on_budget_id"
  end

  create_table "concepts", force: :cascade do |t|
    t.integer "ref"
    t.string "title", null: false
    t.bigint "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_concepts_on_article_id"
  end

  create_table "modifications", force: :cascade do |t|
    t.bigint "amendment_id"
    t.string "type"
    t.bigint "section_id"
    t.bigint "service_id"
    t.bigint "program_id"
    t.bigint "chapter_id"
    t.bigint "article_id"
    t.bigint "concept_id"
    t.bigint "subconcept_id"
    t.string "project"
    t.boolean "project_new"
    t.decimal "amount", precision: 12, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["amendment_id"], name: "index_modifications_on_amendment_id"
    t.index ["article_id"], name: "index_modifications_on_article_id"
    t.index ["chapter_id"], name: "index_modifications_on_chapter_id"
    t.index ["concept_id"], name: "index_modifications_on_concept_id"
    t.index ["program_id"], name: "index_modifications_on_program_id"
    t.index ["section_id"], name: "index_modifications_on_section_id"
    t.index ["service_id"], name: "index_modifications_on_service_id"
    t.index ["subconcept_id"], name: "index_modifications_on_subconcept_id"
  end

  create_table "organisms", force: :cascade do |t|
    t.integer "ref", null: false
    t.string "title", null: false
    t.bigint "section_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["section_id"], name: "index_organisms_on_section_id"
  end

  create_table "programs", force: :cascade do |t|
    t.string "ref", null: false
    t.string "title", null: false
    t.bigint "section_id"
    t.bigint "organism_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organism_id"], name: "index_programs_on_organism_id"
    t.index ["section_id"], name: "index_programs_on_section_id"
  end

  create_table "sections", force: :cascade do |t|
    t.integer "ref", null: false
    t.string "title", null: false
    t.bigint "budget_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["budget_id"], name: "index_sections_on_budget_id"
  end

  create_table "services", force: :cascade do |t|
    t.integer "ref", null: false
    t.string "title", null: false
    t.bigint "section_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["section_id"], name: "index_services_on_section_id"
  end

  create_table "subconcepts", force: :cascade do |t|
    t.integer "ref"
    t.string "title", null: false
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

  add_foreign_key "amendments", "budgets"
  add_foreign_key "amendments", "users"
  add_foreign_key "articles", "chapters"
  add_foreign_key "articulateds", "amendments"
  add_foreign_key "articulateds", "sections"
  add_foreign_key "budgets", "users"
  add_foreign_key "chapters", "budgets"
  add_foreign_key "concepts", "articles"
  add_foreign_key "modifications", "amendments"
  add_foreign_key "modifications", "articles"
  add_foreign_key "modifications", "chapters"
  add_foreign_key "modifications", "concepts"
  add_foreign_key "modifications", "programs"
  add_foreign_key "modifications", "sections"
  add_foreign_key "modifications", "services"
  add_foreign_key "modifications", "subconcepts"
  add_foreign_key "organisms", "sections"
  add_foreign_key "programs", "organisms"
  add_foreign_key "programs", "sections"
  add_foreign_key "sections", "budgets"
  add_foreign_key "services", "sections"
  add_foreign_key "subconcepts", "concepts"
end

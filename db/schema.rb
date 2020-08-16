# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_16_133748) do

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "cost_center"
    t.integer "parent_department_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parent_department_id"], name: "index_departments_on_parent_department_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.integer "title_id", null: false
    t.integer "job_id", null: false
    t.integer "office_id", null: false
    t.integer "department_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["department_id"], name: "index_employees_on_department_id"
    t.index ["job_id"], name: "index_employees_on_job_id"
    t.index ["office_id"], name: "index_employees_on_office_id"
    t.index ["title_id"], name: "index_employees_on_title_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "offices", force: :cascade do |t|
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "mail_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "titles", force: :cascade do |t|
    t.string "name"
    t.integer "rank"
    t.integer "max_employees"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "departments", "departments", column: "parent_department_id"
  add_foreign_key "employees", "departments"
  add_foreign_key "employees", "jobs"
  add_foreign_key "employees", "offices"
  add_foreign_key "employees", "titles"
end

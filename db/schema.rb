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

ActiveRecord::Schema.define(version: 2018_06_19_011959) do

  create_table "cities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "city_type"
    t.string "slug"
    t.string "name_with_type"
    t.string "path"
    t.integer "code"
    t.integer "parent_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "slug"], name: "index_cities_on_name_and_slug"
  end

  create_table "cities_jobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "job_id"
    t.bigint "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_cities_jobs_on_city_id"
    t.index ["job_id", "city_id"], name: "index_cities_jobs_on_job_id_and_city_id", unique: true
    t.index ["job_id"], name: "index_cities_jobs_on_job_id"
  end

  create_table "companies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "address"
    t.string "email"
    t.string "phone"
    t.string "fax"
    t.string "number_of_employees"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "entries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "job_id"
    t.string "entry_name"
    t.string "entry_email"
    t.string "entry_phone"
    t.text "entry_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_entries_on_job_id"
    t.index ["user_id", "job_id"], name: "index_entries_on_user_id_and_job_id", unique: true
    t.index ["user_id"], name: "index_entries_on_user_id"
  end

  create_table "favorite_jobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_favorite_jobs_on_job_id"
    t.index ["user_id"], name: "index_favorite_jobs_on_user_id"
  end

  create_table "industries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_industries_on_name"
  end

  create_table "industries_jobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "job_id"
    t.bigint "industry_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["industry_id"], name: "index_industries_jobs_on_industry_id"
    t.index ["job_id", "industry_id"], name: "index_industries_jobs_on_job_id_and_industry_id", unique: true
    t.index ["job_id"], name: "index_industries_jobs_on_job_id"
  end

  create_table "jobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.bigint "company_id"
    t.string "position"
    t.string "salary"
    t.datetime "expiry_date"
    t.text "description"
    t.datetime "update_date"
    t.boolean "published"
    t.text "welfare"
    t.text "condition"
    t.text "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_jobs_on_company_id"
    t.index ["title", "update_date"], name: "index_jobs_on_title_and_update_date"
    t.index ["title"], name: "index_jobs_on_title"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "prefix", default: ""
    t.string "phone", default: ""
    t.boolean "registration", default: false
    t.text "address"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cities_jobs", "cities"
  add_foreign_key "cities_jobs", "jobs"
  add_foreign_key "entries", "jobs"
  add_foreign_key "entries", "users"
  add_foreign_key "favorite_jobs", "jobs"
  add_foreign_key "favorite_jobs", "users"
  add_foreign_key "industries_jobs", "industries"
  add_foreign_key "industries_jobs", "jobs"
  add_foreign_key "jobs", "companies"
end

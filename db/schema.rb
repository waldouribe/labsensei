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

ActiveRecord::Schema.define(version: 20180921022959) do

  create_table "aki_diagnoses", force: :cascade do |t|
    t.integer  "patient_id"
    t.integer  "creatinine_test_1_id"
    t.integer  "creatinine_test_2_id"
    t.integer  "stage"
    t.string   "reason"
    t.float    "increase_net"
    t.float    "increase_percentage"
    t.datetime "discovered_at"
    t.integer  "time_between_tests"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "aki_diagnoses", ["creatinine_test_1_id"], name: "index_aki_diagnoses_on_creatinine_test_1_id"
  add_index "aki_diagnoses", ["creatinine_test_2_id"], name: "index_aki_diagnoses_on_creatinine_test_2_id"
  add_index "aki_diagnoses", ["patient_id"], name: "index_aki_diagnoses_on_patient_id"

  create_table "alert_kinds", force: :cascade do |t|
    t.integer  "institution_id"
    t.string   "name"
    t.integer  "severity"
    t.text     "description"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "alert_kinds", ["institution_id"], name: "index_alert_kinds_on_institution_id"

  create_table "alert_kinds_parameter_kinds", id: false, force: :cascade do |t|
    t.integer  "alert_kind_id"
    t.integer  "parameter_kind_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "alert_kinds_parameter_kinds", ["alert_kind_id"], name: "index_alert_kinds_parameter_kinds_on_alert_kind_id"
  add_index "alert_kinds_parameter_kinds", ["parameter_kind_id"], name: "index_alert_kinds_parameter_kinds_on_parameter_kind_id"

  create_table "alerts", force: :cascade do |t|
    t.integer  "patient_id"
    t.integer  "alert_kind_id"
    t.integer  "parameter_id"
    t.datetime "date"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "alerts_parameters", id: false, force: :cascade do |t|
    t.integer  "alert_id"
    t.integer  "parameter_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "alerts_parameters", ["alert_id"], name: "index_alerts_parameters_on_alert_id"
  add_index "alerts_parameters", ["parameter_id"], name: "index_alerts_parameters_on_parameter_id"

  create_table "columns", force: :cascade do |t|
    t.integer  "import_result_id"
    t.string   "column_name"
    t.integer  "column_number"
    t.string   "is_valid"
    t.string   "value"
    t.string   "error"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "columns", ["import_result_id"], name: "index_columns_on_import_result_id"

  create_table "creatinine_tests", force: :cascade do |t|
    t.integer  "institution_id"
    t.integer  "patient_id"
    t.string   "private_id"
    t.float    "level"
    t.datetime "performed_at"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "creatinine_tests", ["institution_id"], name: "index_creatinine_tests_on_institution_id"
  add_index "creatinine_tests", ["patient_id"], name: "index_creatinine_tests_on_patient_id"

  create_table "epicrises", force: :cascade do |t|
    t.integer  "patient_id"
    t.boolean  "aki_diagnosis"
    t.integer  "aki_stage"
    t.date     "admission_date"
    t.string   "admission_unit"
    t.date     "discharge_date"
    t.string   "admission_reason"
    t.boolean  "dead"
    t.boolean  "nephrology_assessment"
    t.boolean  "nephrology_appointment"
    t.boolean  "ckd"
    t.boolean  "rrt"
    t.boolean  "intrahospital_sepsis"
    t.boolean  "ami"
    t.boolean  "htn"
    t.boolean  "copd"
    t.boolean  "cld"
    t.boolean  "dm"
    t.boolean  "esrd"
    t.boolean  "tel"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "epicrises", ["patient_id"], name: "index_epicrises_on_patient_id"

  create_table "import_results", force: :cascade do |t|
    t.integer  "import_id"
    t.integer  "row_number"
    t.integer  "patient_id"
    t.integer  "creatinine_test_id"
    t.boolean  "is_valid"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "import_results", ["creatinine_test_id"], name: "index_import_results_on_creatinine_test_id"
  add_index "import_results", ["import_id"], name: "index_import_results_on_import_id"
  add_index "import_results", ["patient_id"], name: "index_import_results_on_patient_id"

  create_table "imports", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "institution_id"
    t.integer  "total_rows"
    t.integer  "valid_rows"
    t.integer  "invalid_rows"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "imports", ["institution_id"], name: "index_imports_on_institution_id"
  add_index "imports", ["user_id"], name: "index_imports_on_user_id"

  create_table "institutions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "plan_id"
    t.string   "plan_status",          default: "ok"
    t.date     "plan_expiration_date"
    t.boolean  "active",               default: true
  end

  add_index "institutions", ["plan_id"], name: "index_institutions_on_plan_id"

  create_table "parameter_group_kinds", force: :cascade do |t|
    t.integer  "institution_id"
    t.string   "name"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "parameter_groups", force: :cascade do |t|
    t.integer  "parameter_group_kind_id"
    t.integer  "patient_id"
    t.datetime "date"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "parameter_groups", ["parameter_group_kind_id"], name: "index_parameter_groups_on_parameter_group_kind_id"
  add_index "parameter_groups", ["patient_id"], name: "index_parameter_groups_on_patient_id"

  create_table "parameter_kinds", force: :cascade do |t|
    t.integer  "parameter_group_kind_id"
    t.string   "name"
    t.string   "parameter_type"
    t.boolean  "deductible",              default: false
    t.string   "units"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "parameter_kinds", ["parameter_group_kind_id"], name: "index_parameter_kinds_on_parameter_group_kind_id"

  create_table "parameters", force: :cascade do |t|
    t.integer  "parameter_group_id"
    t.integer  "parameter_kind_id"
    t.string   "value_string"
    t.boolean  "value_boolean"
    t.integer  "value_integer"
    t.decimal  "value_decimal"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "parameters", ["parameter_group_id"], name: "index_parameters_on_parameter_group_id"
  add_index "parameters", ["parameter_kind_id"], name: "index_parameters_on_parameter_kind_id"

  create_table "patients", force: :cascade do |t|
    t.integer  "institution_id"
    t.string   "private_id"
    t.string   "name"
    t.string   "email"
    t.string   "gender"
    t.date     "birthday"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.datetime "first_aki_diagnosis_at"
  end

  add_index "patients", ["institution_id"], name: "index_patients_on_institution_id"

  create_table "plans", force: :cascade do |t|
    t.string   "name"
    t.integer  "max_cases"
    t.integer  "max_cases_per_month"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "triggers", force: :cascade do |t|
    t.integer  "parameter_kind_id"
    t.integer  "arg0_id"
    t.integer  "arg1_id"
    t.integer  "alert_kind_id"
    t.string   "kind"
    t.decimal  "value"
    t.boolean  "is_custom",         default: false
    t.string   "klass"
    t.string   "function"
    t.text     "description"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "triggers", ["alert_kind_id"], name: "index_triggers_on_alert_kind_id"
  add_index "triggers", ["arg0_id"], name: "index_triggers_on_arg0_id"
  add_index "triggers", ["arg1_id"], name: "index_triggers_on_arg1_id"
  add_index "triggers", ["parameter_kind_id"], name: "index_triggers_on_parameter_kind_id"

  create_table "users", force: :cascade do |t|
    t.integer  "institution_id"
    t.string   "email"
    t.string   "name"
    t.string   "password_digest"
    t.string   "reset_password_token"
    t.string   "auth_token"
    t.string   "role"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token"
  add_index "users", ["institution_id"], name: "index_users_on_institution_id"

end

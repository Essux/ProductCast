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

ActiveRecord::Schema.define(version: 20171017035034) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applied_parameters", force: :cascade do |t|
    t.bigint "parameter_id"
    t.float "value"
    t.bigint "execution_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["execution_id"], name: "index_applied_parameters_on_execution_id"
    t.index ["parameter_id"], name: "index_applied_parameters_on_parameter_id"
  end

  create_table "executions", force: :cascade do |t|
    t.bigint "forecast_set_id"
    t.bigint "model_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["forecast_set_id"], name: "index_executions_on_forecast_set_id"
    t.index ["model_id"], name: "index_executions_on_model_id"
  end

  create_table "forecast_sets", force: :cascade do |t|
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_forecast_sets_on_product_id"
  end

  create_table "forecasts", force: :cascade do |t|
    t.datetime "date"
    t.integer "sales"
    t.bigint "execution_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["execution_id"], name: "index_forecasts_on_execution_id"
  end

  create_table "models", force: :cascade do |t|
    t.string "name"
    t.string "class_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "parameters", force: :cascade do |t|
    t.bigint "model_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["model_id"], name: "index_parameters_on_model_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "records", force: :cascade do |t|
    t.datetime "date"
    t.integer "sales"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_records_on_product_id"
  end

  add_foreign_key "applied_parameters", "executions"
  add_foreign_key "applied_parameters", "parameters"
  add_foreign_key "executions", "forecast_sets"
  add_foreign_key "executions", "models"
  add_foreign_key "forecast_sets", "products"
  add_foreign_key "forecasts", "executions"
  add_foreign_key "parameters", "models"
  add_foreign_key "records", "products"
end

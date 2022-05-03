# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_05_03_223853) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "device_categories", force: :cascade do |t|
    t.string "device_name"
    t.decimal "price"
    t.string "device_items"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "device_data", force: :cascade do |t|
    t.bigint "device_id", null: false
    t.bigint "user_id", null: false
    t.float "spo2"
    t.integer "heart_rate"
    t.float "temperature"
    t.float "gps", default: [], array: true
    t.bigint "ecg", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id"], name: "index_device_data_on_device_id"
    t.index ["user_id"], name: "index_device_data_on_user_id"
  end

  create_table "devices", force: :cascade do |t|
    t.bigint "device_category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_category_id"], name: "index_devices_on_device_category_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.string "specialization"
    t.integer "years_experience"
    t.decimal "salary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendships", force: :cascade do |t|
    t.bigint "requester_id", null: false
    t.bigint "requestee_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["requestee_id"], name: "index_friendships_on_requestee_id"
    t.index ["requester_id"], name: "index_friendships_on_requester_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_likes_on_post_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "patients", force: :cascade do |t|
    t.decimal "weight"
    t.decimal "height"
    t.boolean "smoking"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.text "content"
    t.string "category"
    t.bigint "user_id", null: false
    t.integer "comments_counter"
    t.integer "likes_counter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "gender"
    t.date "birth_date"
    t.integer "age"
    t.string "address"
    t.string "role"
    t.bigint "reference_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "device_data", "devices"
  add_foreign_key "device_data", "users"
  add_foreign_key "devices", "device_categories"
  add_foreign_key "friendships", "users", column: "requestee_id"
  add_foreign_key "friendships", "users", column: "requester_id"
  add_foreign_key "likes", "posts"
  add_foreign_key "likes", "users"
  add_foreign_key "posts", "users"
end

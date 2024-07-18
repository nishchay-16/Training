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

ActiveRecord::Schema[7.1].define(version: 2024_07_18_052501) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "author_name", null: false
    t.string "nationality"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", primary_key: "isbn", id: :string, force: :cascade do |t|
    t.string "title", null: false
    t.bigint "author_id", null: false
    t.bigint "genre_id", null: false
    t.integer "quantity", null: false
    t.integer "available_quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_books_on_author_id"
    t.index ["genre_id"], name: "index_books_on_genre_id"
    t.index ["isbn"], name: "index_books_on_isbn", unique: true
  end

  create_table "fines", force: :cascade do |t|
    t.bigint "library_transaction_id", null: false
    t.decimal "fine_amount", precision: 10, scale: 2
    t.date "fine_date"
    t.string "payment_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["library_transaction_id"], name: "index_fines_on_library_transaction_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "genre_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "librarians", force: :cascade do |t|
    t.string "librarian_name", null: false
    t.string "email"
    t.string "phone_no"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "library_transactions", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.string "isbn", null: false
    t.date "issuedate"
    t.date "returndate"
    t.bigint "librarian_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["librarian_id"], name: "index_library_transactions_on_librarian_id"
    t.index ["member_id"], name: "index_library_transactions_on_member_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "member_name", null: false
    t.date "dob"
    t.string "phone_no"
    t.string "email"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "books", "authors"
  add_foreign_key "books", "genres"
  add_foreign_key "fines", "library_transactions"
  add_foreign_key "library_transactions", "books", column: "isbn", primary_key: "isbn"
  add_foreign_key "library_transactions", "librarians"
  add_foreign_key "library_transactions", "members"
end

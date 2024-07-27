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

ActiveRecord::Schema[7.1].define(version: 2024_07_27_114823) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.bigint "supplier_id", null: false
    t.string "account_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "accountable_type"
    t.bigint "accountable_id"
    t.index ["accountable_type", "accountable_id"], name: "index_accounts_on_accountable"
    t.index ["supplier_id"], name: "index_accounts_on_supplier_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "published_at"
  end

  create_table "assemblies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "assemblies_parts", id: false, force: :cascade do |t|
    t.bigint "assembly_id"
    t.bigint "part_id"
    t.index ["assembly_id"], name: "index_assemblies_parts_on_assembly_id"
    t.index ["part_id"], name: "index_assemblies_parts_on_part_id"
  end

  create_table "authors", force: :cascade do |t|
    t.string "author_name"
    t.string "nationality"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "books_count", default: 0, null: false
  end

  create_table "books", force: :cascade do |t|
    t.string "isbn"
    t.string "title"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "available_quantity"
    t.bigint "author_id", null: false
    t.bigint "genre_id", null: false
    t.index ["author_id"], name: "index_books_on_author_id"
    t.index ["genre_id"], name: "index_books_on_genre_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.string "commentable_type", null: false
    t.bigint "commentable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
  end

  create_table "distributions", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_distributions_on_name"
  end

  create_table "fines", force: :cascade do |t|
    t.decimal "fine_amount"
    t.date "fine_date"
    t.string "payment_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string "genre_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.integer "stock"
    t.boolean "available"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "librarians", force: :cascade do |t|
    t.string "librarian_name"
    t.string "email"
    t.string "phone_no"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email_confirmation"
    t.integer "number_of_books"
    t.integer "year_established"
    t.string "library_code"
    t.integer "max_capacity"
    t.integer "number_of_staff"
    t.string "status"
    t.string "size"
    t.string "subdomain"
    t.string "surname"
  end

  create_table "members", force: :cascade do |t|
    t.string "member_name"
    t.date "dob"
    t.string "phone_no"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
  end

  create_table "parts", force: :cascade do |t|
    t.string "part_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "picture_files", force: :cascade do |t|
    t.string "filepath"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", primary_key: ["customer_id", "product_sku"], force: :cascade do |t|
    t.integer "customer_id", null: false
    t.string "product_sku", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supplier_accounts", force: :cascade do |t|
    t.bigint "supplier_id", null: false
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_supplier_accounts_on_account_id"
    t.index ["supplier_id"], name: "index_supplier_accounts_on_supplier_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.string "isbn"
    t.date "issuedate"
    t.date "returndate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "book_id"
    t.bigint "librarian_id"
    t.index ["book_id"], name: "index_transactions_on_book_id"
    t.index ["librarian_id"], name: "index_transactions_on_librarian_id"
    t.index ["member_id"], name: "index_transactions_on_member_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "type"
    t.string "color"
    t.decimal "price", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "accounts", "suppliers"
  add_foreign_key "books", "genres"
  add_foreign_key "supplier_accounts", "accounts"
  add_foreign_key "supplier_accounts", "suppliers"
  add_foreign_key "transactions", "books"
  add_foreign_key "transactions", "librarians"
  add_foreign_key "transactions", "members"
end

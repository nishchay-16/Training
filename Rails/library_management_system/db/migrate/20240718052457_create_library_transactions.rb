class CreateLibraryTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :library_transactions do |t|
      t.references :member, null: false, foreign_key: true
      t.string :isbn, null: false
      t.date :issuedate
      t.date :returndate
      t.references :librarian, null: false, foreign_key: true

      t.timestamps
    end

    add_foreign_key :library_transactions, :books, column: :isbn, primary_key: :isbn
  end
end

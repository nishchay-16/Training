class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books, id: false do |t|
      t.string :isbn, null: false, primary_key: true
      t.string :title, null: false
      t.references :author, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true
      t.integer :quantity, null: false
      t.integer :available_quantity, null: false

      t.timestamps
    end

    add_index :books, :isbn, unique: true
  end
end
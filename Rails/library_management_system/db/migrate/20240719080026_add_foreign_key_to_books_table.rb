class AddForeignKeyToBooksTable < ActiveRecord::Migration[7.1]
  def change
    # Add new columns
    add_column :books, :author_id, :bigint, null: false
    add_column :books, :genre_id, :bigint, null: false

    # Add indexes for new columns
    add_index :books, :author_id
    add_index :books, :genre_id

    # Add foreign key constraints
    add_foreign_key :books, :authors
    add_foreign_key :books, :genres
  end

end

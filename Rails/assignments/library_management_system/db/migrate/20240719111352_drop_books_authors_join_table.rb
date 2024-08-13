class DropBooksAuthorsJoinTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :books_authors_join_table do |t|
      # The block can be omitted if no table creation options are needed.
      # The block is typically used when creating a table, not when dropping it.
    end

  end
end

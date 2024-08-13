class RenameJoinTableToBookAurthorJoin < ActiveRecord::Migration[7.1]
  def change
    rename_table :authors_books, :books_authors_join_table
  end
end

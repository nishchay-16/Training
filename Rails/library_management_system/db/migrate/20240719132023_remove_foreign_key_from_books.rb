class RemoveForeignKeyFromBooks < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :books, :authors
  end
end

class AddAvailableQuantityToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :available_quantity, :integer
  end
end

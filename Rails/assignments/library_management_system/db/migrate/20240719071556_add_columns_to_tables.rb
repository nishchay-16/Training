class AddColumnsToTables < ActiveRecord::Migration[7.1]
  def change
    add_column :members , :address, :string
    add_column :librarians, :stream, :string
  end
end

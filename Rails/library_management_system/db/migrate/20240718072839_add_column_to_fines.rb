class AddColumnToFines < ActiveRecord::Migration[7.1]
  def change
    add_column :fines, :fine_day, :string
  end
end

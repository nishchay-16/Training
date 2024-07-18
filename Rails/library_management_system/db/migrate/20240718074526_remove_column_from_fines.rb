class RemoveColumnFromFines < ActiveRecord::Migration[7.1]
  def change
    remove_column :fines, :fine_day, :string
  end
end

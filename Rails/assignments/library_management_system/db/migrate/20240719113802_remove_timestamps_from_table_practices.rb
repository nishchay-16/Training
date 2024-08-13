class RemoveTimestampsFromTablePractices < ActiveRecord::Migration[7.1]
  def change
    remove_column :table_practices, :created_at, :datetime, null: false
    remove_column :table_practices, :updated_at, :datetime, null: false
  end
end

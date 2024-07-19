class RemoveIndexFromTablePractices < ActiveRecord::Migration[7.1]
  def change
    remove_index :table_practices, name: 'index_table_practices_on_full_name_renamed'
  end
end

class RenameIndexOnTablePractices < ActiveRecord::Migration[7.1]
  def change
    rename_index :table_practices, :index_table_practices_on_full_name, :index_table_practices_on_full_name_renamed
  end
end

class DropTablePractices < ActiveRecord::Migration[7.1]
  def change
    drop_table :table_practices, if_exists: true, force: :cascade
  end
end

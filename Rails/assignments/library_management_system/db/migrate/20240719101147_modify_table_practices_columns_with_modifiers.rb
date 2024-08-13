class ModifyTablePracticesColumnsWithModifiers < ActiveRecord::Migration[7.1]
  def change
    change_column_null :table_practices, :full_name, false
    add_column :table_practices, :description, :string, limit: 255, collation: "en_US.UTF-8", default: "No description", comment: "Description of the practice"
    add_column :table_practices, :rating, :decimal, precision: 5, scale: 2, comment: "Rating of the practice"
  end
end

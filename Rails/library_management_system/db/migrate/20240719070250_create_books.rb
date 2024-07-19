class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :title
      t.integer :quantity

      t.timestamps
    end
  end
end

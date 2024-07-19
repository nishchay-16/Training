class CreateTablePractice < ActiveRecord::Migration[7.1]
  def change
    create_table :table_practices do |t|
      t.string :name  
      t.integer :age
      t.string :gender

      t.timestamps
    end
  end
end

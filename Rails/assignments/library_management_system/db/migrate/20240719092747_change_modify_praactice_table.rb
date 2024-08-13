class ChangeModifyPraacticeTable < ActiveRecord::Migration[7.1]
  def change
    change_table :table_practices do |t|
      t.remove :name , :age 
      t.string :full_name
      t.index :full_name
      t.rename :gender , :gender_name
    end
  end
end

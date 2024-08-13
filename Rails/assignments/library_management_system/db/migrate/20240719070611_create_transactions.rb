class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.references :member, null: false, foreign_key: true
      t.string :isbn
      t.date :issuedate
      t.date :returndate

      t.timestamps
    end
  end
end

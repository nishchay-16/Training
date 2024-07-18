class CreateFines < ActiveRecord::Migration[7.1]
  def change
    create_table :fines do |t|
      t.references :library_transaction, null: false, foreign_key: true
      t.decimal :fine_amount, precision: 10, scale: 2
      t.date :fine_date
      t.string :payment_status

      t.timestamps
    end
  end
end

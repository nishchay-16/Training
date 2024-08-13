class CreateFines < ActiveRecord::Migration[7.1]
  def change
    create_table :fines do |t|
      t.decimal :fine_amount
      t.date :fine_date
      t.string :payment_status

      t.timestamps
    end
  end
end

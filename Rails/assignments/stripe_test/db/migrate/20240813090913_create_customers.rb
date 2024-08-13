class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.string :email
      t.string :stripe_customer_id

      t.timestamps
    end
  end
end

class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products, primary_key: [:customer_id, :product_sku] do |t|
      t.integer :customer_id, null: false
      t.string :product_sku, null: false
      t.text :description

      t.timestamps
    end
  end
end

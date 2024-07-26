class CreateSupplierAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :supplier_accounts do |t|
      t.references :supplier, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end

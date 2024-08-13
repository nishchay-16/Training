class AddReferenceToTransactionTable < ActiveRecord::Migration[7.1]
  def change
    add_reference :transactions, :book, foreign_key: true
  end
end

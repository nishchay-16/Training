class AddLibrarianRefToTransactions < ActiveRecord::Migration[7.1]
  def change
    add_reference :transactions, :librarian, foreign_key: true
  end
end

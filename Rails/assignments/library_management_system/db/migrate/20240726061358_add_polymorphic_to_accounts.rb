class AddPolymorphicToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_reference :accounts, :accountable, polymorphic: true, null: true
  end
end

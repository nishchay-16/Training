module MyApplication;   
  class SupplierAccount < ApplicationRecord
    belongs_to :supplier,
      class_name: "MyApplication::Business::Supplier"

    belongs_to :account,
      class_name: "MyApplication::Billing::Account"
  end
end
  
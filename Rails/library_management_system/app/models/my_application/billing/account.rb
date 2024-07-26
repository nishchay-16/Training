module MyApplication
  module Billing
    class Account < ApplicationRecord
      belongs_to :supplier,
      # belongs_to :accountable, polymorphic: true,
      # belongs_to :supplier, inverse_of: :account,
        class_name: "MyApplication::Business::Supplier"

      has_many :supplier_accounts,
        class_name: "MyApplication::SupplierAccount"

    end
  end
end

module MyApplication
    module Business
      class Supplier < ApplicationRecord
        has_one :account,
          class_name: "MyApplication::Billing::Account"
      end
    end
  end
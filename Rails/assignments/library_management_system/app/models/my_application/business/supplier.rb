module MyApplication
    module Business
      class Supplier < ApplicationRecord
        # has_one :account,
        has_one :account, autosave: true,
        # has_one :account, dependent: :destroy,
        # has_one :account, disable_joins: true,
        # has_one :account, ensuring_owner_was: true,
        # has_one :account, foreign_key: "supplier_id",
        # has_one :account, inverse_of: :supplier,
        # has_one :account, primary_key: "custom_id",
        # has_one :account, query_constraints: ->(relation) { relation.where("accounts.active = ?", true) },
        # has_one :account, required: true,
        # has_one :account, strict_loading: true,
        # has_one :account, through: :supplier_account,
        # has_one :account, through: :supplier_accounts, source: :account,
        # has_one :account, touch: true,
        # has_one :account, validate: true,
          class_name: "MyApplication::Billing::Account"

        has_one :supplier_account,
          class_name: "MyApplication::SupplierAccount"

        has_one :comment, as: :commentable
        # has_one :comment, as: :commentable, source_type: "Supplier"
        def create_comment(attributes = {})
          build_comment(attributes).tap(&:save)
        end
      end
    end
  end 
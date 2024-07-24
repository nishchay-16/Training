class Member < ApplicationRecord
    has_many :transactions
    validates :email, presence: true, email: true
end

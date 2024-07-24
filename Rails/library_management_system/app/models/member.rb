class Member < ApplicationRecord
    validates :email, presence: true, email: true
end

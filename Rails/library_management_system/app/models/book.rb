class Book < ApplicationRecord
    belongs_to :author
    belongs_to :genre
    has_many :transactions
    validates :title, presence: true, length: { minimum: 5 }

    # validate do |book|
    #     # errors.add :title, :too_plain, message: "not cool enough"
    #     errors.add :base, :invalid, message: "This person is invalid because ..."
    #   end

end

class Book < ApplicationRecord
    # belongs_to :author, autosave: true
    # belongs_to :author, class_name: "Patron"
    # belongs_to :author, class_name: "Patron",foreign_key: "patron_id"
    # belongs_to :author, inverse_of: :books
    # belongs_to :author, touch: true   
    # belongs_to :author, strict_loading: true
    belongs_to :author, counter_cache: :books_count
    # belongs_to :author, touch: true
    # belongs_to :author, validate: true
    # belongs_to :author, optional: true

    belongs_to :genre
    has_many :transactions
    validates :title, presence: true, length: { minimum: 5 }

    # validate do |book|
    #     # errors.add :title, :too_plain, message: "not cool enough"
    #     errors.add :base, :invalid, message: "This person is invalid because ..."
    #   end

end

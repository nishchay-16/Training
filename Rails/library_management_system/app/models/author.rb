class Author < ApplicationRecord
  has_many :books, dependent: :destroy
    # Custom validation method
    validate :check_author_name_format
    def check_author_name_format
      unless author_name.match?(/\A[A-Za-z]+\z/)
        errors.add(:author_name, "must only contain letters")
      end
    end
    
  end
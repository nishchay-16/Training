class Author < ApplicationRecord
  # has_many :books, dependent: :destroy
  # has_many :books, dependent: :nullify
  # has_many :books, -> { extending FindRecentExtension }
  # has_many :books, inverse_of: :author

  
    # Custom validation method

    # validate :check_author_name_format
    # def check_author_name_format
    #   unless author_name.match?(/\A[A-Za-z]+\z/)
    #     errors.add(:author_name, "must only contain letters")
    #   end
    # end

  has_many :books, before_add: :check_book_limit, after_add: :update_books_count, after_remove: :update_books_count

  private

  def check_book_limit(book)
    if books_count >= 2
      puts "Cannot add book: Limit of 2 books reached."
      throw(:abort)
    end
  end

  def update_books_count(book)
    update(books_count: books.count)
  end
    
end
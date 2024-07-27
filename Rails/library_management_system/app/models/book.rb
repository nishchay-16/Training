class Book < ApplicationRecord
  # belongs_to :author, autosave: true
  # belongs_to :author, class_name: "Patron"
  # belongs_to :author, class_name: "Patron",foreign_key: "patron_id"
  # belongs_to :author, inverse_of: :books
  # belongs_to :author, touch: true   
  # belongs_to :author, strict_loading: true
  # belongs_to :author, touch: true
  # belongs_to :author, validate: true
  # belongs_to :author, optional: true
  belongs_to :author, counter_cache: :books_count
  after_save :update_author_books_count
  before_destroy :check_if_removable

  # belongs_to :genre
  has_many :transactions
  validates :title, presence: true, length: { minimum: 5 }
  
  # validate do |book|
  #     # errors.add :title, :too_plain, message: "not cool enough"
  #     errors.add :base, :invalid, message: "This person is invalid because ..."
  #   end
  
  belongs_to :genre, touch: true
  # after_destroy :log_destroy_action

  after_touch do
    puts 'A Book was touched'
  end

  # def log_destroy_action
  #   puts 'Book destroyed'
  # end

  def update_author_books_count
    author.update(books_count: author.books.count)
  end

  def check_if_removable
    if quantity > 0
      puts "Cannot remove book with quantity greater than zero."
      throw(:abort) 
    end
  end

end

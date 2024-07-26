class Genre < ApplicationRecord
  has_many :books
  VALID_GENRES = %w(fiction non-fiction fantasy mystery romance thriller)

  # validates :genre_name, inclusion: { 
  #   in: VALID_GENRES, 
  #   message: "%{value} is not a valid genre" }
  #   allow_nil: true
  #   allow_blank: true

  validates :genre_name, presence: { message: "must be given please" }

  validates :genre_name, uniqueness: true, on: :create
  validates :genre_name, uniqueness: true, on: :update

  validates :genre_name, presence: {strict: true}
end

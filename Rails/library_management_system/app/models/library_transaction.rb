class LibraryTransaction < ApplicationRecord
  belongs_to :member
  belongs_to :librarian
end

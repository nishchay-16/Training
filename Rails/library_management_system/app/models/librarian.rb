class Librarian < ApplicationRecord
    # validates :librarian_name, presence: true
    # validates :librarian_name, presence: { message: 'must be present' }


    # -------------->   ACCEPTANCE VALIDATION (not working)
    # validates :phone_no, acceptance: true
    # validates :phone_no, acceptance: { accept: "yes" }



    # -------------->   CONFIRMATION VALIDATION
    # validates :email, confirmation: true
    # validates :email_confirmation, presence: true

    # -------------->   CASE SENSITIVE VALIDATION   
    # validates :email, confirmation: { case_sensitive: false }


    # -------------->   COMPARISON VALIDATION
    # validates :email, comparison: { greater_than: "a@b.com" }
    # validates :start_date, comparison: { greater_than: :end_date }
    # validates :number_of_books, comparison: { greater_than: 0}
    validates :number_of_books, comparison: { greater_than_or_equal_to: 1}
    # validates :number_of_books, comparison: { less_than: 1000}
    # validates :number_of_books, comparison: { less_than_or_equal_to: 1000}
    # validates :number_of_books, comparison: { greater_than: 0, message: "must be greater than 0" }


end

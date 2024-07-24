class Librarian < ApplicationRecord
  has_many :transactions
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
    validates :number_of_books, comparison: { greater_than: 0}
    # validates :number_of_books, comparison: { greater_than_or_equal_to: 1}
    # validates :number_of_books, comparison: { less_than: 1000}
    # validates :number_of_books, comparison: { less_than_or_equal_to: 1000}
    # validates :number_of_books, comparison: { greater_than: 0, message: "must be greater than 0" }


    # -------------->   FORMAT VALIDATION
    # validates :librarian_name, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
    # validates :librarian_name, format: { without: /\A[a-zA-Z]+\z/, message: "only allows numbers" }


    # -------------->   INCLUSION VALIDATION
    validates :status, inclusion: { in: ["active", "inactive"] }
    # validates :size, inclusion: { in: %w(small medium large),  message: "%{value} is not a valid size" }
    

    # -------------->   EXCLUSION VALIDATION
    validates :subdomain, exclusion: { in: %w(www us ca jp), message: "%{value} is reserved." }
    # validates :status, exclusion: { in: ["active", "inactive"] }


    # -------------->   LENGTH VALIDATION
    # validates :librarian_name, length: { maximum: 10 }
    # validates :librarian_name, length: { is: 10 }
    # validates :librarian_name, length: { minimum: 10 }
    validates :librarian_name, length: { in: 2..20 }
    # validates :librarian_name, length: { maximum: 10, too_long: "is too long (maximum is %{count} characters)" }
    # validates :librarian_name, length: { is: 10, wrong_length: "must be exactly %{count} characters" }
    # validates :librarian_name, length: { minimum: 10, too_short: "is too short (minimum is %{count} characters)" }
    # validates :librarian_name, length: { in: 10..20, too_short: "is too short (minimum is %{count} characters)", too_long: "is too long (maximum is %{count} characters)" }


    # -------------->   NUMERICALITY VALIDATION
    validates :phone_no, numericality: true
    # validates :phone_no, numericality: { greater_than: 20 }
    # validates :phone_no, numericality: { only_integer: true }
    # validates :phone_no, numericality: { odd: true }
    # validates :phone_no, numericality: { even: true }

    
    # -------------->   PRESENCE VALIDATION
    validates :librarian_name, presence: true
    # validates :librarian_name, presence: { message: 'must be present' }


    # -------------->   ABSENCE VALIDATION
    # validates :librarian_name, absence: true


    # -------------->   UNIQUENESS VALIDATION
    validates :phone_no , uniqueness: true
    # validates :email, uniqueness: { case_sensitive: false }


    # -------------->   VALIDATES_ASSOCIATION (will do after ACTIVE RECORD ASSOCIATIONS)


    # -------------->   VALIDATES_EACH
    validates_each :librarian_name, :surname do |record, attr, value|
      record.errors.add(attr, 'must start with upper case') if /\A[[:lower:]]/.match?(value)
    end


    # -------------->   VALIDATES_WITH
    # validates_with GoodnessValidator
    # # validates_with GoodnessValidator, on: :create    # only on creating new librarian
    validates_with GoodnessValidator, on: :update    # only on updating existing librarian
    # validates_with GoodnessValidator, fields: [:librarian_name, :surname]   

end


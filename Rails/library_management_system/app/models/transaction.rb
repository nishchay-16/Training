class Transaction < ApplicationRecord
  belongs_to :member
  belongs_to :book
  belongs_to :librarian

  #          Conditional Validations 

  # -------> Using a Symbol with :if and :unless
  #  validates :isbn, presence: true, if: :book_present?
  #  def book_present?
  #    book_id.present?
  #  end

  # ------> Using a Proc with :if and :unless
  #  validates :isbn, presence: true, unless: Proc.new { |t| t.issuedate.blank? }   # using proc
  #  validates :isbn, presence: true, unless: -> { issuedate.blank? }               # using lambda

# -------> Grouping Conditional Validations
  def involves_special_member?
    member_id == 1
  end
  with_options if: :involves_special_member? do |transaction|
    transaction.validates :isbn, presence: true
    transaction.validates :book_id, presence: true
    transaction.validates :issuedate, presence: true
  end

  # ------> Combining Validation Conditions
  # validates :isbn, :book_id, :issuedate, presence: true,
  # if: -> { member_id == 1 },
  # unless: -> { returndate.present? }

end

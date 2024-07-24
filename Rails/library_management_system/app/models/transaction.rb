class Transaction < ApplicationRecord
  # belongs_to :member

   # Conditional validations

  #  validates :isbn, presence: true, if: :book_present?
  #  def book_present?
  #    book_id.present?
  #  end


  #  validates :isbn, presence: true, unless: Proc.new { |t| t.issuedate.blank? }   # using proc
  #  validates :isbn, presence: true, unless: -> { issuedate.blank? }               # using lambda


  def involves_special_member?
    member_id == 1
  end
  with_options if: :involves_special_member? do |transaction|
    transaction.validates :isbn, presence: true
    transaction.validates :book_id, presence: true
    transaction.validates :issuedate, presence: true
  end


  # validates :isbn, :book_id, :issuedate, presence: true,
  # if: -> { member_id == 1 },
  # unless: -> { returndate.present? }

end

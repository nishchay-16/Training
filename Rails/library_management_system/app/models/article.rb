class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, length: { minimum: 10 }

  before_validation :normalize_title                   # before_validation callback
  after_validation :set_default_content                # after_validation callback

  private

  # Callback methods
  def normalize_title
    self.title = title.downcase.titleize if title.present?
  end

  def set_default_content
    self.content = "Default content" if content.blank?
  end

end

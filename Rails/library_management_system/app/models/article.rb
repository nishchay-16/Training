class Article < ApplicationRecord
  # validates :title, presence: true
  validates :content, length: { minimum: 10 }

  before_validation :normalize_title                   # before_validation callback
  after_validation :set_default_content                # after_validation callback
  before_save :ensure_title_has_a_value                # before_save callback
  around_save :log_save_actions                        # around_save callback
  after_save :update_search_index                      # after_save callback

  private

  # Callback methods
  def normalize_title
    self.title = title.downcase.titleize if title.present?
  end

  def set_default_content
    self.content = "Default content" if content.blank?
  end

  def ensure_title_has_a_value
    self.title = "Untitled" if title.blank?
  end

  def log_save_actions
    puts "Around Save: Before Save"
    yield
    puts "Around Save: After Save"
  end

  def update_search_index
    puts "After Save: Updated search index"
  end

end

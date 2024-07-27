class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, length: { minimum: 10 }

  # before_validation :normalize_title                   # before_validation callback
  # after_validation :set_default_content                # after_validation callback
  # before_save :ensure_title_has_a_value                # before_save callback
  # around_save :log_save_actions                        # around_save callback
  # after_save :update_search_index                      # after_save callback
  # before_create :set_published_at                      # before_create callback
  # around_create :log_create_actions                    # around_create callback
  # after_create :send_notification                      # after_create callback
  # after_commit :commit_log, on: [:create, :update]     # after_commit callback
  # after_rollback :rollback_log                         # after_rollback callback
  # before_update :log_before_update                     # before_update callback
  # around_update :log_around_update                     # around_update callback
  # after_update :log_after_update                       # after_update callback
  before_destroy :log_before_destroy                   # before_destroy callback
  after_destroy :log_after_destroy                     # after_destroy callback
  around_destroy :log_around_destroy                   # around_destroy callback

  private

  # Callback methods
  # def normalize_title
  #   self.title = title.downcase.titleize if title.present?
  # end

  # def set_default_content
  #   self.content = "Default content" if content.blank?
  # end

  # def ensure_title_has_a_value
  #   self.title = "Untitled" if title.blank?
  # end

  # def log_save_actions
  #   puts "Around Save: Before Save"
  #   yield
  #   puts "Around Save: After Save"
  # end
  
  # def update_search_index
  #   puts "After Save: Updated search index"
  # end

  # def set_published_at
  #   self.published_at = Time.current if published_at.nil?
  # end

  # def log_create_actions
  #   puts "Around Create: Before Create"
  #   yield
  #   puts "Around Create: After Create"
  # end

  # def send_notification
  #   puts "After Create: Notification sent to the author"
  # end


  # def commit_log
  #   puts "After Commit: Changes have been committed"
  # end

  # def rollback_log
  #   puts "After Rollback: Transaction rolled back"
  # end

  # def log_before_update
  #   puts "Before Update: Log before update"
  # end

  # def log_around_update
  #   puts "Around Update: Before update"
  #   yield
  #   puts "Around Update: After update"
  # end

  # def log_after_update
  #   puts "After Update: Log after update"
  # end

  def log_before_destroy
    puts "Before Destroy: Destroyed the article no #{id} at #{Time.current}"
  end

  def log_after_destroy
    puts "After Destroy: Successfully destroyed the article #{title}"
  end

  def log_around_destroy
    puts "Around Destroy: Started Destroying the article no #{id}"
    yield
    puts "Around Destroy: The article no #{id} has been destroyed"
  end

end

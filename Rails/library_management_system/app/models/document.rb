class Document < ApplicationRecord
  after_create_commit :log_creation
  after_update_commit :log_update
  after_destroy_commit :log_destruction
  after_save_commit :log_document_saved_to_db

  private

  def log_creation
    puts "Document with ID #{id} has been created."
  end

  def log_update
    puts "Document with ID #{id} has been updated."
  end

  def log_destruction
    puts "Document with ID #{id} has been destroyed."
  end

  def log_document_saved_to_db
    puts 'Document was saved to database'
  end
end

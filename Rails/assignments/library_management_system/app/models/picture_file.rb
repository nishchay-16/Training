class PictureFile < ApplicationRecord
  # after_destroy FileDestroyerCallback.new

  # Callback to delete file only after the transaction is committed
  after_commit :delete_picture_file_from_disk, on: :destroy

  # Callback to handle actions if the transaction is rolled back
  after_rollback :rollback_picture_file_deletion, on: :destroy

  def delete_picture_file_from_disk
    if File.exist?(filepath)
      File.delete(filepath)
    end
  end

  def rollback_picture_file_deletion
    puts "Transaction rolled back, did not delete: #{filepath}"
  end
end

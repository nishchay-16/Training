class AddAttachmentsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :attachments, :json
  end
end

class AddIndexOnComments < ActiveRecord::Migration[7.1]
  def change
    add_index :comments, [:commentable_type, :commentable_id]
  end
end

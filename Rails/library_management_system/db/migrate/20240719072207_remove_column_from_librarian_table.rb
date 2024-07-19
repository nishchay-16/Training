class RemoveColumnFromLibrarianTable < ActiveRecord::Migration[7.1]
  def change
    remove_column :librarians, :stream , :string
  end
end

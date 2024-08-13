class AddSizeColumnToLibrarian < ActiveRecord::Migration[7.1]
  def change
    add_column :librarians, :size, :string
    add_column :librarians, :subdomain, :string
  end
end

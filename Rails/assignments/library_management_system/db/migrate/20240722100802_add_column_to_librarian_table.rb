class AddColumnToLibrarianTable < ActiveRecord::Migration[7.1]
  def change
    add_column :librarians, :email_confirmation, :string
    add_column :librarians, :number_of_books, :integer
    add_column :librarians, :year_established, :integer
    add_column :librarians, :library_code, :string
    add_column :librarians, :max_capacity, :integer
    add_column :librarians, :number_of_staff, :integer
    add_column :librarians, :status, :string
  end
end

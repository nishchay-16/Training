class AddCsvFileToAdmins < ActiveRecord::Migration[7.1]
  def change
    add_column :admins, :csv_file, :string
  end
end

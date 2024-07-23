class AddFieldsToDistributorTable < ActiveRecord::Migration[7.1]
  def change
    add_column :librarians, :surname, :string
  end
end

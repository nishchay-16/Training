class CreateLibrarians < ActiveRecord::Migration[7.1]
  def change
    create_table :librarians do |t|
      t.string :librarian_name, null: false
      t.string :email
      t.string :phone_no
      t.string :address

      t.timestamps
    end
  end
end

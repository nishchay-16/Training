class CreateEmailContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :email_contacts do |t|
      t.string :name
      t.string :email
      t.text :message

      t.timestamps
    end
  end
end

class CreateMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :members do |t|
      t.string :member_name, null: false
      t.date :dob
      t.string :phone_no
      t.string :email
      t.string :address

      t.timestamps
    end
  end
end

class CreateMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :members do |t|
      t.string :member_name
      t.date :dob
      t.string :phone_no
      t.string :email

      t.timestamps
    end
  end
end

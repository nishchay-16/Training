class CreateAuthors < ActiveRecord::Migration[7.1]
  def change
    create_table :authors do |t|
      t.string :author_name, null: false
      t.string :nationality

      t.timestamps
    end
  end
end

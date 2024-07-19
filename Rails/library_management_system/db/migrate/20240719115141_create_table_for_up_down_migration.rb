class CreateTableForUpDownMigration < ActiveRecord::Migration[7.1]
  def up
    create_table :distributors do |t|
      t.string :zipcode
    end
  end

  def down
    drop_table :distributors
  end
end

class CreateVehicles < ActiveRecord::Migration[7.1]
  def change
    create_table :vehicles do |t|
      t.string :type
      t.string :color
      t.decimal :price, precision: 10, scale: 2

      t.timestamps
    end
  end
end

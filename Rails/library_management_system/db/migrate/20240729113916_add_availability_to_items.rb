class AddAvailabilityToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :availability, :integer, default: 0, null: false
  end
end

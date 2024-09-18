class AddScheduledTimeToAdmins < ActiveRecord::Migration[7.1]
  def change
    add_column :admins, :scheduled_time, :datetime
  end
end

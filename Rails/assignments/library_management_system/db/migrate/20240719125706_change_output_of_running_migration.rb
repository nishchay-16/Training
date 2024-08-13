class ChangeOutputOfRunningMigration < ActiveRecord::Migration[7.1]
  def change
    suppress_messages do
      create_table :distributions do |t|
        t.string :name
        t.text :description
        t.timestamps
      end
    end

    say "Created a table"

    suppress_messages { add_index :distributions, :name }
    say "Added an index on name in table distribution!", true

    say_with_time 'Waiting for a while' do
      sleep 1
      250
    end
  end
end

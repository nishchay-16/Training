class ThrowingErrorToPreventRevert < ActiveRecord::Migration[7.1]
  def up
    drop_table :distributors
  end

  def down
    # raise ActiveRecord::IrreversibleMigration, "Cannot reverse the drop of the 'distributors' table"
  end
end

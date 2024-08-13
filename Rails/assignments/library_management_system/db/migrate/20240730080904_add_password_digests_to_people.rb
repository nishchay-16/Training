class AddPasswordDigestsToPeople < ActiveRecord::Migration[7.1]
  def change
    add_column :people, :password_digest, :string
    add_column :people, :recovery_password_digest, :string
  end
end

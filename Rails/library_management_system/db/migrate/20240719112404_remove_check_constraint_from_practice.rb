class RemoveCheckConstraintFromPractice < ActiveRecord::Migration[7.1]
  def change
    remove_check_constraint :table_practices, name: 'rating_check'
  end
end

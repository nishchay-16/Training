class AddCheckConstraintToPractice < ActiveRecord::Migration[7.1]
  def change
    add_check_constraint :table_practices, 'rating >= 0 AND rating <= 10', name: 'rating_check'
  end
end

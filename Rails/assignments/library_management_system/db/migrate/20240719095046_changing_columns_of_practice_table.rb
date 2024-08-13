class ChangingColumnsOfPracticeTable < ActiveRecord::Migration[7.1]
  def change
    # Changing the data type of a column
    change_column :table_practices, :gender_name, :text
    
    # Changing null constraints
    change_column_null :table_practices, :full_name, false

    # Changing default values
    change_column_default :table_practices, :gender_name, from: nil, to: 'Not specified'
  end
end

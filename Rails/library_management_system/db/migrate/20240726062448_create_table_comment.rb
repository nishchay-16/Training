class CreateTableComment < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :commentable, polymorphic: true, null: false
      t.timestamps
    end
    add_index :comments, [:commentable_type, :commentable_id]
  end
end

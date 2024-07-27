class CreatePictureFiles < ActiveRecord::Migration[7.1]
  def change
    create_table :picture_files do |t|
      t.string :filepath

      t.timestamps
    end
  end
end

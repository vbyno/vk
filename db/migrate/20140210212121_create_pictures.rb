class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :imageable_id, null: false
      t.string :imageable_type, null: false
      t.string :image, null: false
      t.string :alt
      t.string :title

      t.timestamps
    end
  end
end

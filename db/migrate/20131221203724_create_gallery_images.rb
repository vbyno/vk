class CreateGalleryImages < ActiveRecord::Migration
  def change
    create_table :gallery_images do |t|
      t.references :apartment, null: false, index: true
      t.string :image, null: false
      t.string :title
      t.string :alt

      t.timestamps
    end
  end
end

class CreatePhotoTranslations < ActiveRecord::Migration
  def change
    create_table :photo_translations do |t|
      t.references :apartment_translation, null: false, index: true
      t.references :photo, null: false
      t.string :alt
      t.string :title
    end
  end
end

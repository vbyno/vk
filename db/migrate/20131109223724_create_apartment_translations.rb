class CreateApartmentTranslations < ActiveRecord::Migration
  def change
    create_table :apartment_translations do |t|
      t.string :locale, null: false
      t.string :title, null: false
      t.text :description, null: false
      t.belongs_to :apartment, index: true, null: false

      t.timestamps
    end
  end
end

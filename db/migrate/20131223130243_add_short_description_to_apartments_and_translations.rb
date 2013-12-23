class AddShortDescriptionToApartmentsAndTranslations < ActiveRecord::Migration
  def change
    add_column :apartments, :short_description, :string, null: false, default: ''
    add_column :apartment_translations, :short_description, :string, null: false, default: ''
  end
end

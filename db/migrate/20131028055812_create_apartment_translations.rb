class CreateApartmentTranslations < ActiveRecord::Migration
  def up
    Apartment.create_translation_table!(
      { title: :string, description: :text },
      { migrate_data: true }
    )
  end

  def down
    Apartment.drop_translation_table! migrate_data: true
  end
end

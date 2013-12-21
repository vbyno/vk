# == Schema Information
#
# Table name: apartments
#
#  id          :integer          not null, primary key
#  title       :string(255)      not null
#  price       :decimal(6, 2)    not null
#  description :text             not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Apartment < ActiveRecord::Base
  has_many :translations, class_name: ApartmentTranslation, dependent: :destroy

  validates :title, presence: true
  validates :price, presence: true
  validates :description, presence: true

  scope :translated_to, ->(locale) {
    joins(:translations).where(apartment_translations: { locale: locale })
  }

  %w[title description].each do |attribute|
    define_method "translated_#{attribute}", ->(locale) do
      translations.find_by(locale: locale).try(attribute)
   end
 end
end

# == Schema Information
#
# Table name: apartments
#
#  id                :integer          not null, primary key
#  title             :string(255)      not null
#  price             :decimal(6, 2)    not null
#  description       :text             not null
#  created_at        :datetime
#  updated_at        :datetime
#  main_photo_id     :integer
#  active            :boolean          default(FALSE), not null
#  short_description :string(255)      default(""), not null
#

class Apartment < ActiveRecord::Base
  belongs_to :main_photo, class_name: GalleryImage
  has_many :photos, class_name: GalleryImage, dependent: :destroy
  has_many :translations, class_name: ApartmentTranslation, dependent: :destroy
  has_many :reservations, dependent: :destroy

  accepts_nested_attributes_for :photos

  validates :title, :price, :description, :short_description, presence: true
  validates :main_photo, presence: true, if: :active?

  scope :active, -> { where(active: true) }
  scope :translated_to, ->(locale) {
    joins(:translations).where(apartment_translations: { locale: locale })
  }

  %w[title description].each do |attribute|
    define_method "translated_#{attribute}", ->(locale) do
      translations.find_by(locale: locale).try(attribute)
   end
 end
end

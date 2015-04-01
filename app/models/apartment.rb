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
#  permalink         :string           not null
#

class Apartment < ActiveRecord::Base
  belongs_to :main_photo, class_name: Photo
  has_many :photos, dependent: :destroy
  has_many :translations, class_name: ApartmentTranslation, dependent: :destroy
  has_many :reservations, dependent: :destroy

  accepts_nested_attributes_for :photos, allow_destroy: true

  validates :title, :price, :description, :short_description, :permalink,
            presence: true
  validates :main_photo, presence: true, if: :active?
  validates :permalink, uniqueness: true, permalink: true

  scope :active, -> { where(active: true) }
  scope :translated_to, ->(locale) {
    joins(:translations).where(apartment_translations: { locale: locale })
  }

  def self.available!(permalink)
    active.find_by!(permalink: permalink.to_s)
  end

  def secondary_photos
    photos.excluding(main_photo_id)
  end

  def locales_with_translations
    values = Locale::SECONDARY.map { |locale|
      translations.detect {|t| t.locale == locale }
    }
    Hash[Locale::SECONDARY.zip values]
  end

  def parent
    MainPage.available!(Locale::DEFAULT)
  end
end

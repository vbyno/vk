# == Schema Information
#
# Table name: apartment_translations
#
#  id                :integer          not null, primary key
#  locale            :string(255)      not null
#  title             :string(255)      not null
#  description       :text             not null
#  apartment_id      :integer          not null
#  created_at        :datetime
#  updated_at        :datetime
#  short_description :string(255)      default(""), not null
#

class ApartmentTranslation < ActiveRecord::Base
  belongs_to :apartment
  has_many :photos, through: :apartment
  has_many :photo_translations, dependent: :destroy

  accepts_nested_attributes_for :photo_translations,
                                allow_destroy: true,
                                reject_if: proc { |pt| pt[:title].blank? &&
                                                         pt[:alt].blank? }
  validates :locale,
            presence: true,
            inclusion: { in: Locale::SECONDARY },
            uniqueness: { scope: :apartment_id }
  validates :title, :description, :short_description, :apartment,
            presence: true

  scope :by_apartment_ids, ->(ids, locale) { where(apartment_id: ids,
                                                   locale: locale) }
  def forced_photo_translations
    photo_ids = photos.pluck(:id) - photo_translations.pluck(:photo_id)
    photo_ids.each do |photo_id|
      photo_translations.build(photo_id: photo_id)
    end
    photo_translations
  end

  def parent
    MainPage.available!(locale)
  end
end

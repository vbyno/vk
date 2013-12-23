# == Schema Information
#
# Table name: apartment_translations
#
#  id           :integer          not null, primary key
#  locale       :string(255)      not null
#  title        :string(255)      not null
#  description  :text             not null
#  apartment_id :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#

class ApartmentTranslation < ActiveRecord::Base
  LOCALES = Locale::SECONDARY_LOCALES.map(&:to_s)

  belongs_to :apartment

  validates :locale,
            presence: true,
            inclusion: { in: LOCALES },
            uniqueness: { scope: :apartment_id }
  validates :title, :description, :short_description, :apartment, presence: true

  scope :by_apartment_ids, ->(ids, locale) { where(apartment_id: ids, locale: locale) }
end

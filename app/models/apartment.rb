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
  has_many :apartment_translations

  validates :title, presence: true
  validates :price, presence: true
  validates :description, presence: true

  scope :translated_to, ->(locale) {
    joins(:apartment_translations)
    .where(apartment_translations: { locale: locale })
    .includes(:apartment_translations)
  }
end

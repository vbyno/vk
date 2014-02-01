# == Schema Information
#
# Table name: photo_translations
#
#  id                       :integer          not null, primary key
#  apartment_translation_id :integer          not null
#  photo_id                 :integer          not null
#  alt                      :string(255)
#  title                    :string(255)
#

class PhotoTranslation < ActiveRecord::Base
  belongs_to :apartment_translation
  belongs_to :photo

  delegate :image, to: :photo, prefix: false

  validates :apartment_translation, :photo, presence: true
end

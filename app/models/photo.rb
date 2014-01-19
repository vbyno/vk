# == Schema Information
#
# Table name: photos
#
#  id           :integer          not null, primary key
#  apartment_id :integer          not null
#  image        :string(255)      not null
#  title        :string(255)
#  alt          :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Photo < ActiveRecord::Base
  belongs_to :apartment

  validates :image, :apartment, presence: true

  mount_uploader :image, GalleryImageUploader
end

# == Schema Information
#
# Table name: pictures
#
#  id             :integer          not null, primary key
#  imageable_id   :integer          not null
#  imageable_type :string(255)      not null
#  image          :string(255)      not null
#  alt            :string(255)
#  title          :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

class Picture < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
  validates :imageable, :image, presence: true
end

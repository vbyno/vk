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
  validate :title, presence: true
  validate :price, presence: true
  validate :description, presence: true

  translates :title, :description
end

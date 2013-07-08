# == Schema Information
#
# Table name: apartments
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  price       :decimal(6, 2)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Apartment < ActiveRecord::Base
end

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

require 'spec_helper'

describe Apartment do
  pending "add some examples to (or delete) #{__FILE__}"
end

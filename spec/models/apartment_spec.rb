# == Schema Information
#
# Table name: apartments
#
#  id         :integer          not null, primary key
#  price      :decimal(6, 2)    not null
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Apartment do
  it { validate_presence_of :title }
  it { validate_presence_of :price }
  it { validate_presence_of :description }
end

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

require 'spec_helper'

describe Apartment do
  it { expect(subject).to have_many(:translations)
                            .class_name(ApartmentTranslation)
                            .dependent(:destroy) }

  it { expect(subject).to validate_presence_of :title }
  it { expect(subject).to validate_presence_of :price }
  it { expect(subject).to validate_presence_of :description }
end

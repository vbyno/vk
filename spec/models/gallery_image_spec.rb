# == Schema Information
#
# Table name: gallery_images
#
#  id           :integer          not null, primary key
#  apartment_id :integer          not null
#  image        :string(255)      not null
#  title        :string(255)
#  alt          :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe GalleryImage do
  it { expect(subject).to belong_to :apartment }
  it { expect(subject).to validate_presence_of :apartment }
  it { expect(subject).to validate_presence_of :image }
end

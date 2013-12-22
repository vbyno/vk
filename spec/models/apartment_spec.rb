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
  it { expect(subject).to belong_to(:main_image).class_name(GalleryImage) }
  it { expect(subject).to have_many(:translations)
                            .class_name(ApartmentTranslation)
                            .dependent(:destroy) }
  it { expect(subject).to have_many :gallery_images }

  it { expect(subject).to validate_presence_of :title }
  it { expect(subject).to validate_presence_of :price }
  it { expect(subject).to validate_presence_of :description }

  context 'main image' do
    let(:active) { build :apartment, active: true, main_image: nil }
    let(:inactive) { build :apartment, active: false, main_image: nil }
    let(:active_with_main_image) { build :apartment, :active_with_main_image }

    it 'can be empty for inactive apartment' do
      expect(inactive).to be_valid
    end

    it 'should present for active apartment' do
      expect(active).not_to be_valid
    end

    it 'is valid if apartment active' do
      expect(active_with_main_image).to be_valid
    end
  end

  describe '#translated_title & #translated_description' do
    let(:apartment) { create :apartment }
    let!(:ua_translation) { create :apartment_translation,
                                  apartment: apartment,
                                  title: 'UA Title',
                                  description: 'UA description',
                                  locale: 'ua' }

    %w[title description].each do |attribute|
      it "returns translated #{attribute}" do
        expect(apartment.public_send("translated_#{attribute}", :ua)).to eq(
          ua_translation.public_send(attribute)
        )
      end
    end
  end
end

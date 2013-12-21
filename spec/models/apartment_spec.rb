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
  let(:apartment) { create :apartment }

  it { expect(subject).to have_many(:translations)
                            .class_name(ApartmentTranslation)
                            .dependent(:destroy) }

  it { expect(subject).to validate_presence_of :title }
  it { expect(subject).to validate_presence_of :price }
  it { expect(subject).to validate_presence_of :description }

  describe '#translated_title & #translated_description' do
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

# == Schema Information
#
# Table name: apartment_translations
#
#  id           :integer          not null, primary key
#  locale       :string(255)      not null
#  title        :string(255)      not null
#  description  :text             not null
#  apartment_id :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe ApartmentTranslation do
  let(:apartment) { create :apartment }
  let(:apartment_translation) { create :apartment_translation, apartment: apartment }

  it 'has appropriate locales lists' do
    expect(ApartmentTranslation::LOCALES).to eq ['ua', 'en', 'pl']
  end

  it { expect(subject).to belong_to :apartment }

  it { expect(subject).to validate_presence_of :locale }
  it { expect(subject).to validate_presence_of :title }
  it { expect(subject).to validate_presence_of :description }
  it { expect(subject).to validate_presence_of :short_description }
  it { expect(subject).to validate_presence_of :apartment }

  it { expect(subject).to ensure_inclusion_of(:locale)
                          .in_array ApartmentTranslation::LOCALES }

  it 'validates uniquness of locale scoped to apartment' do
    apartment_translation
    expect { create :apartment_translation, apartment: apartment }.to raise_error
    expect { create :apartment_translation,
                    locale: 'ua',
                    apartment: apartment }.to_not raise_error
    expect { create :apartment_translation, locale: 'en' }.to_not raise_error
  end
end

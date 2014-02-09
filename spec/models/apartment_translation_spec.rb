# == Schema Information
#
# Table name: apartment_translations
#
#  id                :integer          not null, primary key
#  locale            :string(255)      not null
#  title             :string(255)      not null
#  description       :text             not null
#  apartment_id      :integer          not null
#  created_at        :datetime
#  updated_at        :datetime
#  short_description :string(255)      default(""), not null
#

require 'spec_helper'

describe ApartmentTranslation do
  let(:apartment) { build_stubbed :apartment }

  it { expect(subject).to belong_to :apartment }
  it { expect(subject).to have_many(:photos).through(:apartment) }
  it { expect(subject).to have_many(:photo_translations).dependent(:destroy) }

  %i[locale title description short_description apartment].each do |attribute|
    it { expect(subject).to validate_presence_of attribute }
  end

  it { expect(subject).to ensure_inclusion_of(:locale).
                          in_array Locale::SECONDARY }
  it { expect(subject).to accept_nested_attributes_for(:photo_translations).
                          allow_destroy(true) }

  it 'validates uniquness of locale scoped to apartment' do
    create :apartment_translation, apartment: apartment
    expect { create :apartment_translation, apartment: apartment }.to raise_error
    expect { create :apartment_translation,
                    locale: Locale::UK,
                    apartment: apartment }.to_not raise_error
    expect { create :apartment_translation, locale: Locale::EN }
      .to_not raise_error
  end

  describe '#forced_photo_translations' do
    subject(:forced_photo_translations) {
      apartment_translation.forced_photo_translations
    }
    let(:photo) { create :photo }
    let(:apartment_translation) { create :apartment_translation,
                                         apartment: photo.apartment }

    it 'returns existed translation' do
      photo_translation = create(:photo_translation,
                                 photo: photo,
                                 apartment_translation: apartment_translation)
      expect(forced_photo_translations).to eq [photo_translation]
    end

    it 'builds new photo translation and returns it' do
      expect { forced_photo_translations }.
             to change { apartment_translation.photo_translations.size }.
             from(0).to(1)
      expect(apartment_translation.photo_translations.first).to be_new_record
    end
  end
end

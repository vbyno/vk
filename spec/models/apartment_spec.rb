# == Schema Information
#
# Table name: apartments
#
#  id                :integer          not null, primary key
#  title             :string(255)      not null
#  price             :decimal(6, 2)    not null
#  description       :text             not null
#  created_at        :datetime
#  updated_at        :datetime
#  main_photo_id     :integer
#  active            :boolean          default(FALSE), not null
#  short_description :string(255)      default(""), not null
#  permalink         :string           not null
#

require 'spec_helper'

describe Apartment do
  it { expect(subject).to belong_to(:main_photo).class_name(Photo) }
  it { expect(subject).to have_many(:translations).
                            class_name(ApartmentTranslation).
                            dependent(:destroy) }
  it { expect(subject).to have_many(:photos).dependent(:destroy) }
  it { expect(subject).to have_many(:reservations).dependent(:destroy) }

  it { expect(subject).to accept_nested_attributes_for(:photos).
                            allow_destroy(true) }

  it_behaves_like 'presence validator',
    %i[title price description short_description permalink]

  describe '.available!' do
    let(:apartment) { create :apartment,
                             :active_with_main_photo,
                             permalink: 'foobar' }
    subject { described_class.available!(apartment.permalink) }

    it 'finds apartment' do
      expect(subject).to eq apartment
    end
  end

  context 'main image' do
    let(:active) { build :apartment, active: true, main_photo: nil }
    let(:inactive) { build :apartment, active: false, main_photo: nil }
    let(:active_with_main_photo) { build :apartment, :active_with_main_photo }

    it 'can be empty for inactive apartment' do
      expect(inactive).to be_valid
    end

    it 'should present for active apartment' do
      expect(active).not_to be_valid
    end

    it 'is valid if apartment active' do
      expect(active_with_main_photo).to be_valid
    end
  end

  describe '#secondary_photos' do
    let(:apartment) { build :apartment }
    let(:photo) { create :photo, apartment: apartment }
    let(:secondary_photo) { create :photo, apartment: apartment}
    subject(:secondary_photos) { apartment.secondary_photos }

    it 'does not include main photo' do
      apartment.main_photo = photo

      expect(secondary_photos).to eq [secondary_photo]
    end
  end

  describe '#locales_with_translations' do
    let(:apartment) { build :apartment }
    let(:en_translation) {
      build :apartment_translation, locale: Locale::EN, apartment: apartment
    }
    let(:pl_translation) {
      build :apartment_translation, locale: Locale::PL, apartment: apartment
    }
    subject(:locales_with_translations) { apartment.locales_with_translations }

    it 'returns empty set if no translations' do
      expect(locales_with_translations).
        to eq({ Locale::UA => nil, Locale::EN => nil, Locale::PL => nil })
    end

    it 'returns set of locales' do
      allow(apartment).to receive(:translations).and_return [
        pl_translation, en_translation
      ]

      expect(locales_with_translations).to eq({
        Locale::UA => nil,
        Locale::EN => en_translation,
        Locale::PL => pl_translation
      })
    end
  end
end

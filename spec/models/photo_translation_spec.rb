# == Schema Information
#
# Table name: photo_translations
#
#  id                       :integer          not null, primary key
#  apartment_translation_id :integer          not null
#  photo_id                 :integer          not null
#  alt                      :string(255)
#  title                    :string(255)
#

require 'spec_helper'

describe PhotoTranslation do
  it { expect(subject).to belong_to :photo }
  it { expect(subject).to belong_to :apartment_translation }
  it_behaves_like 'presence validator', [:photo, :apartment_translation]

  describe '#image' do
    let(:photo) { build :photo }
    let(:photo_translation) { build :photo_translation, photo: photo }
    subject(:image) { photo_translation.image }

    it 'delegates #image to photo' do
      expect(image).not_to be_nil
      expect(image).to eq photo.image
    end
  end
end

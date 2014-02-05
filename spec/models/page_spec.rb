# == Schema Information
#
# Table name: pages
#
#  id              :integer          not null, primary key
#  type            :string(255)
#  parent_id       :integer
#  permalink       :string(255)      not null
#  locale          :string(255)      not null
#  content         :text             not null
#  active          :boolean          default(FALSE), not null
#  seo_title       :string(255)      not null
#  seo_description :string(255)
#  seo_keywords    :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

require 'spec_helper'

describe Page do
  let(:page) { build :page }

  it_behaves_like 'presence validator', %i[permalink locale content seo_title]

  it { expect(subject).to ensure_inclusion_of(:locale).in_array(Locale::ALL) }
  it { expect(subject).to ensure_inclusion_of(:type).in_array(Page::TYPES) }

  describe '#child?' do
    it 'returns false' do
      expect(page.child?).to be_false
    end
  end

  describe '#parent?' do
    it 'returns false' do
      expect(page.parent?).to be_false
    end
  end

  describe '#to_param' do
    it 'returns permalink' do
      expect(page.to_param).to eq page.permalink
    end
  end
end

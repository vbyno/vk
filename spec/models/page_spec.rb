# == Schema Information
#
# Table name: pages
#
#  id              :integer          not null, primary key
#  type            :string(255)      not null
#  parent_id       :integer
#  permalink       :string(255)      not null
#  title           :string(255)      not null
#  intro           :string(255)      not null
#  content         :text             not null
#  locale          :string(255)      not null
#  active          :boolean          default(FALSE), not null
#  priority        :integer          default(0), not null
#  seo_title       :string(255)      not null
#  seo_description :string(255)
#  seo_keywords    :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

require 'spec_helper'

describe Page do
  let(:page) { build :page }

  it_behaves_like 'presence validator',
    %i[permalink locale content seo_title title intro type priority]

  it { expect(subject).to validate_inclusion_of(:locale).in_array(Locale::ALL) }
  it { expect(subject).to validate_inclusion_of(:type).in_array(Page::TYPES) }
  it { expect(subject).to validate_length_of(:title).is_at_least(2).is_at_most(60) }

  describe 'parent page validation' do
    let(:parent_page) { build :page, type: ParentPage.to_s, parent_id: 1 }
    let(:child_page) { build :page, type: ChildPage.to_s, parent_id: nil }

    before do
      I18n.locale = Locale::DEFAULT
    end

    it 'works for child page' do
      expect(child_page).not_to be_valid
      child_page.parent_id = 1
      expect(child_page).to be_valid
    end

    it 'works for parent page' do
      expect(parent_page).not_to be_valid
      parent_page.parent_id = nil
      expect(parent_page).to be_valid
    end
  end

  describe '#child?' do
    it 'returns false' do
      expect(page).not_to be_child
    end
  end

  describe '#parent?' do
    it 'returns false' do
      expect(page).not_to be_parent
    end
  end
end

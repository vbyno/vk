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

describe ChildPage do
  it { expect(subject).to belong_to(:parent_page).
                          with_foreign_key(:parent_id) }
  it { expect(subject).to have_many(:pictures) }

  it 'validates uniquness of permalink' do
    create :child_page, locale: Locale::RU, permalink: 'foo'

    expect(build :child_page, locale: Locale::RU, permalink: 'foo').
      not_to be_valid
    expect(build :parent_page, locale: Locale::RU, permalink: 'foo').to be_valid
    expect(build :child_page, locale: Locale::RU, permalink: 'bar').to be_valid
    expect(build :child_page, locale: Locale::UA, permalink: 'foo').to be_valid
  end

  describe '#child?' do
    let(:child_page) { build :child_page }

    it 'returns true' do
      expect(child_page.child?).to be_truthy
    end
  end
end

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

  it 'validates uniquness of permalink' do
    create :child_page, locale: 'ru', permalink: 'foo'
    expect(build :child_page, locale: 'ru', permalink: 'foo').not_to be_valid
    expect(build :parent_page, locale: 'ru', permalink: 'foo').to be_valid
    expect(build :child_page, locale: 'ru', permalink: 'bar').to be_valid
    expect(build :child_page, locale: 'ua', permalink: 'foo').to be_valid
  end

  describe '#child?' do
    let(:child_page) { build :child_page }

    it 'returns true' do
      expect(child_page.child?).to be_true
    end
  end
end

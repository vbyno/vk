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

describe ParentPage do
  it { expect(subject).to have_many(:child_pages).
                          with_foreign_key(:parent_id) }
  it { expect(subject).to have_many(:pictures) }

  it 'validates uniquness of permalink' do
    create :parent_page, locale: Locale::RU, permalink: 'foo'

    expect(build :parent_page, locale: Locale::RU, permalink: 'foo').
      not_to be_valid
    expect(build :child_page, locale: Locale::RU, permalink: 'foo').to be_valid
    expect(build :parent_page, locale: Locale::RU, permalink: 'bar').to be_valid
    expect(build :parent_page, locale: Locale::UK, permalink: 'foo').to be_valid
  end

  describe '#parent?' do
    let(:parent_page) { build :parent_page }

    it 'returns true' do
      expect(parent_page.parent?).to be_true
    end
  end
end

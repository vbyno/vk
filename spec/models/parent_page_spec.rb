# == Schema Information
#
# Table name: pages
#
#  id              :integer          not null, primary key
#  type            :string(255)      not null
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

describe ParentPage do
  let(:parent_page) { build :parent_page }

  it { expect(subject).to have_many(:child_pages).
                          with_foreign_key(:parent_id) }
  it { expect(subject).to validate_presence_of :type }

  it 'validates uniquness of permalink' do
    create :parent_page, locale: 'ru', permalink: 'foo'
    expect(build :parent_page, locale: 'ru', permalink: 'foo').not_to be_valid
    expect(build :child_page, locale: 'ru', permalink: 'foo').to be_valid
    expect(build :parent_page, locale: 'ru', permalink: 'bar').to be_valid
    expect(build :parent_page, locale: 'ua', permalink: 'foo').to be_valid
  end

  describe '#parent?' do
    it 'returns true' do
      expect(parent_page.parent?).to be_true
    end
  end
end

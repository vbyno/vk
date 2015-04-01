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

class ParentPage < Page
  has_many :child_pages, foreign_key: :parent_id
  has_many :pictures, as: :imageable

  validates :permalink, presence: true, uniqueness: { scope: :locale }

  def parent?
    true
  end

  def parent
    MainPage.available!(locale)
  end

  def presenter
    ParentPagePresenter.new(self)
  end

  def self.grouped_by_locale
    #TODO what for :includes? doesn't foreign key fix the problem?
    includes(:child_pages).group_by { |p| p.locale.to_sym }
  end
end

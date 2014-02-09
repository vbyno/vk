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

  validates :permalink, presence: true, uniqueness: { scope: :locale }

  scope :for_menu, ->(locale, limit) { where(locale: locale, active: true).
                                         order(priority: :desc).limit(limit) }

  def parent?
    true
  end
end

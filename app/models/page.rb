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

class Page < ActiveRecord::Base
  validates :content, :seo_title, presence: true
  validates :permalink, presence: true, uniqueness: { scope: :locale }
  validates :locale, presence: true, inclusion: { in: Locale::ALL }

  def parent?
    false
  end

  def child?
    false
  end
end

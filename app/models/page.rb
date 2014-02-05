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
  TYPES = %w[ParentPage ChildPage].to_set

  validates :content, :seo_title, presence: true
  validates :permalink, presence: true
  validates :locale, presence: true, inclusion: { in: Locale::ALL }
  validates :type, presence: true, inclusion: { in: TYPES }

  def parent?
    false
  end

  def child?
    false
  end

  def to_param
    permalink
  end
end

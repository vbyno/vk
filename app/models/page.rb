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

class Page < ActiveRecord::Base
  include ActiveModel::Validations
  include ::ModelNameCustomizer
  self.param_key = :page
  self.route_key = :pages

  TYPES = %w[MainPage ParentPage ChildPage].to_set

  scope :active, -> { where(active: true) }
  scope :recent, ->(count, locale) { active.where(locale: locale.to_s).
                                            order(created_at: :desc).
                                            limit(count) }

  validates_with PageValidator
  validates :content, :seo_title, :intro, :permalink, :type, :priority,
            presence: true
  validates :locale, presence: true, inclusion: { in: Locale::ALL }
  validates :type, presence: true, inclusion: { in: TYPES }
  validates :title, presence: true, length: { in: 2..60 }

  def parent?
    false
  end

  def child?
    false
  end

  def main?
    false
  end

  def self.available!(permalink)
    active.find_by!(permalink: permalink.to_s)
  end
end

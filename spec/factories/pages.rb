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

FactoryGirl.define do
  factory :page, class: Page do
    sequence(:permalink) { |n| "page_#{n}" }
    sequence(:title) { |n| "Page #{n} Title" }
    intro 'Short intro for page'
    locale 'ru'
    content { "<p>#{Faker::Lorem.paragraph}</p>" }
    seo_title 'Seo Title'
    priority 0
    active true

    factory :parent_page, class: ParentPage do
      sequence(:title) { |n| "Parent Page #{n} Title" }
      sequence(:permalink) { |n| "parent_#{n}" }
    end

    factory :child_page, class: ChildPage do
      association :parent_page
      sequence(:title) { |n| "Child Page #{n} Title" }
      sequence(:permalink) { |n| "child_#{n}" }
    end

    factory :main_page, class: MainPage do
      title 'Main Page'
      permalink 'ru'
    end
  end
end

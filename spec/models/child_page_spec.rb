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

require 'spec_helper'

describe ChildPage do
  let(:parent_page) { create :parent_page }
  let(:child_page) { create :child_page, parent_page: parent_page }

  it { expect(subject).to belong_to(:parent_page)
                          .with_foreign_key(:parent_id) }
  it { expect(subject).to validate_presence_of :parent_page }
end

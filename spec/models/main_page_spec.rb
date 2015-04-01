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

require 'spec_helper'

describe MainPage do
  describe 'permalink validation' do
    let(:main_page) { build :main_page, permalink: Locale::EN, locale: Locale::RU }

    it 'validates permalink' do
      expect(main_page).not_to be_valid
      main_page.locale = Locale::EN
      expect(main_page).to be_valid
    end
  end
end

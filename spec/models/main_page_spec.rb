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

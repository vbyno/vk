require 'acceptance_helper'

describe '/' do
  root_pages = Locale::ALL_LOCALES.map { |l|
    BasicPage.new(Locale.new(l).root_page_path,
                  main_content: I18n.t('apartments.index.headline'))
  }

  context 'with no data' do
    root_pages.each do |root_page|
      it "#{root_page.url} is accessible" do
        expect(root_page.visit!).to be_loaded
      end
    end
  end
end
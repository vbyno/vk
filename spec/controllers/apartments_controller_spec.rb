require 'spec_helper'

describe ApartmentsController do
  describe 'GET #index' do
    context 'default locale' do
      let!(:main_page) { create :main_page, permalink: Locale::DEFAULT }

      it 'assigns active main page' do
        get :index
        expect(assigns :main_page).to eq main_page
      end
    end

    context 'not default locale' do
      let!(:en_main_page) { create :main_page, permalink: Locale::EN }

      it 'does not assigns main page with another locale' do
        get :index
        expect(assigns :main_page).to be_nil
      end

      it 'assigns locale main page' do
        get :index, locale: 'en'
        expect(assigns :main_page).to eq en_main_page
      end
    end
  end
end

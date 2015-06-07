require 'spec_helper'

describe ApartmentsController do
  describe 'GET #show' do
    let(:apartment) { create :apartment, :active_with_main_photo }

    context 'default locale' do
      it 'assigns active main page' do
        get :show, permalink: apartment.permalink
        expect(assigns :apartment).to eq apartment
      end

      it 'assigns apartment' do
        expect {
          get :show, permalink: 'blah-blah-blah'
        }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context 'not default locale' do
      let!(:apartment_translation) {
        create :apartment_translation, apartment: apartment, locale: Locale::EN
      }

      it 'assigns apartment anyway' do
        get :show, locale: Locale::EN, permalink: apartment.permalink
        expect(assigns :apartment).to eq apartment
      end
    end
  end
end

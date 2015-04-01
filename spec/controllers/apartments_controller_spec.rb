require 'spec_helper'

describe ApartmentsController do
  describe 'GET #show' do
    let(:apartment) { create :apartment, :active_with_main_photo }
    let(:apartment_presenter) { ApartmentPresenter.new(apartment) }
    delegate :permalink, to: :apartment

    context 'default locale' do
      it 'assigns active main page' do
        get :show, permalink: permalink
        expect(assigns :apartment).to eq apartment_presenter
      end
    end

    context 'not default locale' do
      let!(:apartment_translation) {
        create :apartment_translation, apartment: apartment, locale: Locale::EN
      }
      let(:translated_apartment) {
        ApartmentPresenter.new(apartment, apartment_translation)
      }

      it 'assigns apartment' do
        get :show, locale: Locale::EN, permalink: permalink
        expect(assigns :apartment).to eq translated_apartment
      end

      it 'assigns apartment' do
        expect {
          get :show, locale: Locale::UA, permalink: permalink
        }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end

require 'spec_helper'

describe ApartmentsController do
  let!(:apartment) { create :apartment }

  describe 'GET index' do
    it 'assigns all apartments as @apartments' do
      get :index
      expect(assigns :apartments).to eq [apartment]
    end
  end

  describe 'GET show' do
    it 'assigns the requested apartment as @apartment' do
      get :show, { id: apartment.to_param }
      expect(assigns :apartment).to eq apartment
    end
  end
end

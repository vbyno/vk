require 'spec_helper'

describe Admin::PagesController do
  before do
    sign_in create(:admin)
  end

  describe 'GET #index' do
    let(:page) { create :parent_page }

    it 'renders template' do
      get :index
      expect(response).to render_template :index
    end

    it 'assigns pages' do
      get :index
      expect(assigns(:pages)).to eq [page]
    end
  end

  describe 'GET #new' do
    it 'renders template' do
      get :new
      expect(response).to render_template :new
    end
  end
end

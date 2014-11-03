require 'spec_helper'

describe ParentPagesController do
  describe 'GET #show' do
    let(:parent_page) { create :parent_page }

    it 'renders template' do
      get :show, parent_permalink: parent_page.permalink
      expect(response).to render_template :show
    end

    it 'assigns parent_page' do
      get :show, parent_permalink: parent_page.permalink
      expect(assigns(:parent_page)).to eq parent_page
    end

    it 'throws exception if record was not found' do
      expect { get :show, parent_permalink: 'bla-bla-bla' }.
        to raise_error(ActiveRecord::RecordNotFound)
        # in previous implementation ActionController::RoutingError was expected
        # but in production mode RecordNotFound returns 404 page anyway
    end
  end
end

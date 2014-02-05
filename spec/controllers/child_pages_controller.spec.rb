require 'spec_helper'

describe ChildPagesController do
  describe 'GET #show' do
    let(:child_page) { create :child_page }
    let(:params) {
      {
        parent_permalink: child_page.parent_page.permalink,
        child_permalink: child_page.permalink
      }
    }

    it 'renders template' do
      get :show, params
      expect(response).to render_template :show
    end

    it 'assigns child page' do
      get :show, params
      expect(assigns(:page)).to eq child_page
    end

    it 'throws exception if child permalink is wrong' do
      expect { get :show,
                   parent_permalink: child_page.parent_page.permalink,
                   child_permalink: 'bla-bla-bla' }.
             to raise_error(ActionController::RoutingError)
    end

    it 'throws exception if parent permalink is wrong' do
      expect { get :show,
                   parent_permalink: 'bla-bla-bla',
                   child_permalink: child_page.permalink }.
             to raise_error(ActionController::RoutingError)
    end
  end
end
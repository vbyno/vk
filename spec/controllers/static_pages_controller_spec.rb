require 'spec_helper'

describe StaticPagesController do
  describe 'GET sitemap' do
    it 'renders template' do
      get :sitemap
      expect(response).to render_template :sitemap
    end
  end
end


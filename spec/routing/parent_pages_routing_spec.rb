require 'spec_helper'

describe ParentPagesController do
  let(:parent_page) { create :parent_page }

  context 'root level' do
    it 'routes to #show' do
      expect(get 'bar').to route_to(
        'parent_pages#show', parent_permalink: 'bar'
      )
    end

    it 'returns correct url' do
      expect(get parent_page_path(parent_page)).
        to route_to(controller: 'parent_pages', action: 'show',
                    parent_permalink: parent_page.permalink)
    end
  end

  context 'locale level' do
    it 'routes to #show' do
      expect(get "#{Locale::PL}/bar").to route_to(
        'parent_pages#show', parent_permalink: 'bar', locale: 'pl'
      )
    end

    it 'returns correct url' do
      expect(get locale_parent_page_path(Locale::PL, parent_page)).
        to route_to(controller: 'parent_pages',
                    action: 'show',
                    parent_permalink: parent_page.permalink,
                    locale: 'pl')
    end
  end
end

require 'spec_helper'

describe ParentPagesController do
  let(:parent_page) { create :parent_page }

  it 'routes to #show' do
    expect(get 'bar').to route_to('parent_pages#show', parent_permalink: 'bar')
  end

  it 'returns correct url' do
    expect(get parent_page_path(parent_page)).
      to route_to(controller: 'parent_pages', action: 'show',
                  parent_permalink: parent_page.permalink)
  end
end

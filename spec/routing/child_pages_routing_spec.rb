require 'spec_helper'

describe ChildPagesController do
  let(:parent_page) { create :parent_page }
  let(:child_page) { create :child_page, parent_page: parent_page }

  it 'routes to #show' do
    expect(get 'bar/foo').to route_to('child_pages#show',
                                      parent_permalink: 'bar',
                                      child_permalink: 'foo')
  end

  it 'returns correct url' do
    expect(get child_page_path(parent_page, child_page)).
      to route_to(controller: 'child_pages', action: 'show',
                  parent_permalink: parent_page.permalink,
                  child_permalink: child_page.permalink)
  end
end

require 'spec_helper'

describe Admin::PagesController do
  it 'parses index route' do
    expect(get admin_pages_path).
      to route_to(controller: 'admin/pages', action: 'index')
  end

  it 'parses new route' do
    expect(get new_admin_page_path).
      to route_to(controller: 'admin/pages', action: 'new')
  end

  it 'parses create route' do
    expect(post admin_pages_path).
      to route_to(controller: 'admin/pages', action: 'create')
  end
end

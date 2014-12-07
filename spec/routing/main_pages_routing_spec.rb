require 'spec_helper'

describe MainPagesController do
  it 'parse root_path' do
    expect(get root_path).to route_to(controller: 'main_pages',
                                      action: 'show')
  end

  it 'parse locale_root_path' do
    expect(get locale_root_path(Locale::PL)).
      to route_to(controller: 'main_pages', action: 'show', locale: 'pl')
  end
end

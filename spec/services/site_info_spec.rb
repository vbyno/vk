require 'spec_helper'

describe SiteInfo do
  it 'loads yml-file' do
    expect(SiteInfo.get(:contact, :email)).to eq 'vk.lviv.ua@gmail.com'
  end
end

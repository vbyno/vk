require 'spec_helper'

describe SeoTags do
  let(:seo_tag) { SeoTag.new(:title, 'some title')}
  let(:seo_tags) { SeoTags.new([seo_tag]) }

  specify 'delegated methods' do
    expect(seo_tags.count).to eq 1
    expect(seo_tags.first).to eq seo_tag
    expect(seo_tags.last).to eq seo_tag
    expect(seo_tags[0]).to eq seo_tag
    expect(seo_tags[1]).to be_nil
  end
end

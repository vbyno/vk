require 'spec_helper'

describe SeoTagsFactory do
  let(:value) { 'some title' }
  let(:seo_tag) { SeoTag.new(:title, value) }
  let(:seo_tags) { SeoTags.new([seo_tag]) }

  describe '.build' do
    subject(:build_seo_tags) { described_class.build(title: value) }

    it 'builds seo tags' do
      build_seo_tags.first.should == seo_tag
    end
  end

  describe '.create_seo_tag' do
    subject(:create_seo_tag) { described_class.create_seo_tag(:title, value) }

    it 'creates seo tag' do
      create_seo_tag.should == seo_tag
    end
  end
end

class SeoTags
  extend Forwardable
  def_delegators :@seo_tags, :each, :count, :first, :last, :[], :==

  def initialize(seo_tags)
    @seo_tags = Array(seo_tags)
  end
end

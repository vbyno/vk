class SeoTagsFactory
  def self.build(options)
    SeoTags.new(options.map { |args| create_seo_tag(*args) })
  end

  def self.create_seo_tag(name, value)
    SeoTag.new(name, value)
  end
end

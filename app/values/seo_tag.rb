class SeoTag < Struct.new(:name, :value)
  def ==(other)
    name == other.name && value == other.value
  end

  def to_partial_path
    'seo_tags/seo_tag'
  end
end

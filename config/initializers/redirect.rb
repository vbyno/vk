module Redirect
  extend self
  delegate :each, to: :redirects

  def node
    @file ||=
      YAML.load_file(Rails.root.join('config', 'initializers', 'redirects.yml'))
          .with_indifferent_access
  end

  def redirects
    @redirects ||= (node[:children]).inject({}) do |result, (parent_key, children)|
                     result.merge(condition_hash(parent_key, children))
                   end
                   .merge(node[:parents])
  end

private
  def condition_hash(parent_key, children)
    prefix = "#{parent_key}/" if parent_key.in?(['ua', 'en'])
    Hash[children.map { |key, value| ["#{parent_key}/#{key}", "#{prefix}#{value}"] }]
  end
end


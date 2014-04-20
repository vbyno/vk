class SiteInfo
  class UndefinedNode < StandardError; end
  SOURCE_FILE = Rails.root.join('config', 'site_info.yml')

  class << self
    delegate :get, :[], :fetch, :use, to: :site_info

    private

    def site_info
      @site_info ||= new
    end
  end

  def fetch(name)
    nodes.fetch(name) {
      raise UndefinedNode,
            "`#{name}` node was asked expected that #{SOURCE_FILE} has key `#{name}`)"
    }
  end
  alias_method :[], :fetch

  def use(*keys)
    yield get(*keys)
  end

  def get(*keys)
    keys.inject(self) { |hash, key| hash.fetch(key) }
  end

  private

  def nodes
    @nodes ||= YAML.load_file(SOURCE_FILE).with_indifferent_access
  end
end

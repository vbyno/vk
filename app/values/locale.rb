class Locale
  include Rails.application.routes.url_helpers

  DEFAULT = :ru
  ALL = [RU = 'ru', UK = 'uk', EN = 'en', PL = 'pl'].freeze
  ALL_S = ALL.map(&:to_sym).freeze
  SECONDARY = [UK, EN, PL].freeze

  def initialize(locale_param = nil)
    if locale_param && ALL_S.exclude?(locale_param.to_sym)
      raise Exception.new("locale '#{locale_param}' is not appropriate")
    end
    @value = locale_param.try(:to_sym) || DEFAULT
  end

  def self.new!(locale_param = nil)
    new(locale_param).tap(&:make_current!)
  end

  def root_page_path
    default? ? root_path : locale_root_path(to_sym)
  end

  def url_options
    return {} if default?
    { locale: to_sym }
  end

  def make_current!
    I18n.locale = to_sym
  end

  def default?
    to_sym == DEFAULT
  end

  def self.change_to_default!
    default.make_current!
  end

  def self.all_except(locale)
    (ALL_S - [locale.to_sym]).map { |l| new(l) }
  end

  def self.default
    new(DEFAULT)
  end

  def to_s
    to_sym.to_s
  end

  def to_sym
    @value
  end
end
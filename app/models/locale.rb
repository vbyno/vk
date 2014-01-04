class Locale
  include Rails.application.routes.url_helpers

  ALL_LOCALES = Set.new [
    RU = DEFAULT = :ru,
    UA = :ua,
    EN = :en,
    PL = :pl
  ]
  SECONDARY_LOCALES = Set.new [UA, EN, PL]

  def self.new!(locale_param = nil)
    self.new(locale_param).tap(&:change_current!)
  end

  def initialize(locale_param = nil)
    if locale_param && ALL_LOCALES.exclude?(locale_param.to_sym)
      raise Exception.new("locale '#{locale_param}' is not appropriate")
    end
    @value = locale_param.try(:to_sym) || DEFAULT
  end

  def root_page_path
    @root_page_path ||= default? ? root_path : locale_root_path(@value)
  end

  def url_options
    return {} if default?
    { locale: to_sym }
  end

  def change_current!
    I18n.locale = to_i18n
  end

  def to_i18n
    ua? ? :uk : to_sym
  end

  ALL_LOCALES.each do |locale|
    define_method "#{locale}?" do
      to_sym == locale
    end
  end

  def default?
    to_sym == DEFAULT
  end

  def self.change_to_default!
    self.new(DEFAULT).change_current!
  end

  def to_s
    to_sym.to_s
  end

  def to_sym
    @value
  end
end

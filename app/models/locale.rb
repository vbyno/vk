class Locale
  include Rails.application.routes.url_helpers

  ALL_LOCALES = [
    RU = DEFAULT = :ru,
    UA = :ua,
    EN = :en,
    PL = :pl
  ]
  SECONDARY_LOCALES = [UA, EN, PL]

  def self.new!(locale_param = nil)
    locale = self.new(locale_param)
    self.change_current_to(locale)
    locale
  end

  def initialize(locale_param = nil)
    if locale_param && ALL_LOCALES.exclude?(locale_param.to_sym)
      raise Exception.new("locale '#{locale_param}' is not appropriate")
    end
    @value = locale_param.try(:to_sym) || DEFAULT
  end

  def default?
    @value == DEFAULT
  end


  def root_page_path
    @root_page_path ||= default? ? root_path : locale_root_path(@value)
  end

  def to_s
    @value.to_s
  end

  def to_sym
    @value
  end

  def self.change_current_to(locale)
    I18n.locale = locale
  end

  def self.url_options
    return {} if current_is_default?
    { locale: current }
  end

  def self.change_to_default!
    change_current_to(DEFAULT)
  end

  def self.current
    I18n.locale
  end

  def self.current_is_default?
    current == DEFAULT
  end

  private_class_method :current, :current_is_default?
end

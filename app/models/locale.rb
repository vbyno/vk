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
    locale.change_current
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

  def url_options
    return {} if current_is_default?
    { locale: current }
  end

  def to_s
    @value.to_s
  end

  def to_sym
    @value
  end

  def change_current
    I18n.locale = @value
  end

private
  def current
    I18n.locale
  end

  def current_is_default?
    current == DEFAULT
  end
end

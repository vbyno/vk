module ApplicationHelper
  def locale_root(locale)
    if locale == I18n.default_locale
      root_path
    else
      locale_root_path
    end
  end

  def default_locale?(locale = I18n.locale)
    locale == I18n.default_locale
  end
end

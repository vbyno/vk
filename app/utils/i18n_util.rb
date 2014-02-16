module I18nUtil
  def self.value(value)
    I18n.t("values.#{value.underscore}")
  end

  def self.action(value)
    I18n.t("actions.#{value}")
  end
end

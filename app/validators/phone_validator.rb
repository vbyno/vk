class PhoneValidator < BasicEachValidator
  def regexp
    /\A\d{12}\z/
  end

  def error_message
    I18n.t('error_messages.invalid_phone_format')
  end
end

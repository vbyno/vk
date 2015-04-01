class PermalinkValidator < BasicEachValidator
  def regexp
    /\A[a-zA-Z0-9_-]*\z/
  end

  def error_message
    I18n.t('error_messages.invalid_permalink_format')
  end
end

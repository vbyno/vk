class PhoneValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, phone_number)
    unless valid_phone?(phone_number)
      record.errors[attribute] << (options[:message] || error_message)
    end
  end

private

  def valid_phone?(phone_number)
    Phone.valid?(phone_number)
  end

  def error_message
    I18n.t('error_messages.invalid_phone_format')
  end
end

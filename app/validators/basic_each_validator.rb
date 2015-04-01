class BasicEachValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ regexp
      record.errors[attribute] << (options[:message] || error_message)
    end
  end

  def regexp
    raise NotImplementedError
  end

  def error_message
    raise NotImplementedError
  end
end


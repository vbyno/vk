class PhonesFactory
  def self.build(phone_data)
    phone_data.map { |phone_hash| create_phone(*phone_hash) }
  end

  def self.create_phone(operator, values)
    Phone.new(values[:human_number])
  end
end


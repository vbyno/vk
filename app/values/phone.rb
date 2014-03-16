class Phone
  FORMAT = /\A\d{12}\z/

  attr_reader :number

  def self.valid?(value)
    value =~ FORMAT
  end

  def initialize(value)
    @number = to_number(value)
  end

  def to_s
    number
  end

private

  def to_number(value)
    value.to_s.gsub(/[^0-9]/, '')
  end
end

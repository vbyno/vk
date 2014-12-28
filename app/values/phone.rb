class Phone
  FORMAT = /\A\d{12}\z/

  attr_reader :number, :human_number

  def self.valid?(value)
    value =~ FORMAT
  end

  # TODO test it, can be problems with 2 ways of using
  def initialize(human_number)
    @human_number = human_number
    @number = to_number(@human_number)
  end

  def to_s
    number
  end

  def to_partial_path
    'phones/phone'
  end

  def ==(other)
    human_number == other.human_number &&
      number == other.number
  end

private

  def to_number(value)
    value.to_s.gsub(/[^0-9]/, '')
  end
end

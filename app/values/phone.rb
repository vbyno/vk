class Phone
  attr_reader :number, :human_number

  # Hack for not to put 'phones/phone' into view pages.
  # :to_partial_path stil has some problems with Devise (or, maybe, any engine)
  def self.to_partial_path
    'phones/phone'
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
    self.class.to_partial_path
  end

  def ==(other)
    human_number == other.human_number && number == other.number
  end

private

  def to_number(value)
    value.to_s.gsub(/[^0-9]/, '')
  end
end

class BasicButton
  include Capybara::DSL

  def initialize(options = { value: nil })
    @value = options[:value]
  end

  def click!
    click_on @value
  end
end

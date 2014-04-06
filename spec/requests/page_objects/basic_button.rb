class BasicButton
  include Capybara::DSL

  def initialize(value: nil)
    @value = value
  end

  def click!
    click_on @value
  end
end

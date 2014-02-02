require 'zeus/rails'

class CustomPlan < Zeus::Rails
  def test
    require 'simplecov'
    SimpleCov.start 'rails'

    super
  end
end

Zeus.plan = CustomPlan.new

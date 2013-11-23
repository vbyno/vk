class BasePage
  include Capybara::DSL
  include Rails.application.routes.url_helpers

  def initialize(url = root_path)
    @url = url
  end

  def visit!
    visit @url
    self
  end
end

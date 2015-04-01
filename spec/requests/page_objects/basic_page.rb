require 'requests/page_objects/basic_form'
require 'requests/page_objects/basic_button'

class NoSelectorError < ArgumentError; end

class BasicPage
  include Capybara::DSL
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::SanitizeHelper

  attr_reader :url

  def initialize(url = root_path, options = {})
    @url = url
    @main_content = options[:main_content]
  end

  def visit!
    visit url
    self
  end

  def loaded?
    return true if has_content? strip_tags(@main_content)
    raise NoSelectorError, "Expected #{self.class} to have content "\
                           "'#{@main_content}', but it was not found"
  end

  def not_loaded?
    begin
      !loaded?
    rescue NoSelectorError
      return true
    end
  end

  def wait_for_ajax
    counter = 0
    while page.execute_script('return $.active').to_i > 0
      counter += 1
      sleep(0.1)
      raise 'AJAX request took longer than 5 seconds.' if counter >= 50
    end
  end
end

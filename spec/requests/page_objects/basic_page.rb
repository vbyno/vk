require 'requests/page_objects/basic_form'
require 'requests/page_objects/basic_button'

class NoSelectorError < ArgumentError; end

class BasicPage
  include Capybara::DSL
  include Rails.application.routes.url_helpers

  attr_reader :url

  def initialize(url = root_path, options = {})
    @url = url
    @main_content = options[:main_content]
  end

  def visit!
    visit @url
    self
  end

  def loaded?
    return true if has_content? @main_content
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
end

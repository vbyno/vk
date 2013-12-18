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

  def fill_in_tinymce(label, options)
    element_id = find('label', text: label)[:for]
    content = options.delete(:with)

    page.execute_script(
      "tinyMCE.get('#{element_id}').setContent('#{content}')"
    )
  end
end

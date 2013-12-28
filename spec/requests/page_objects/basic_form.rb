require 'requests/page_objects/basic_button'

class BasicForm
  include Capybara::DSL

  def initialize(options = {})
    @tiny_mce_textareas = Array(options[:tiny_mce_textareas])
    @checkboxes = Array(options[:checkboxes])
    @selects = Array(options[:selects])
    @submit = options[:submit]
  end

  def fill_with(params)
    params.each do |label, value|
      if label.in? @tiny_mce_textareas
        fill_in_tinymce label, with: value
      elsif label.in? @checkboxes
        check_in label if value
      elsif label.in? @selects
        select value, from: label
      else
        fill_in label, with: value
      end
    end
    self
  end

  def submit_button
    BasicButton.new(value: @submit)
  end

private
  def fill_in_tinymce(label, options)
    element_id = find('label', text: label)[:for]
    content = options[:with]

    page.execute_script("tinyMCE.get('#{element_id}').setContent('#{content}')")
  end
end

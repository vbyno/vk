class BasicForm
  include Capybara::DSL

  def initialize(options = {})
    @tiny_mce_textareas = Array(options[:tiny_mce_textareas])
    @checkboxes = Array(options[:checkboxes])
    @submit = options[:submit]
  end

  def fill_in_with(params)
    params.each do |label, value|
      if label.in? @tiny_mce_textareas
        fill_in_tinymce label, with: value
      elsif label.in? @checkboxes
        check_in label if value
      else
        fill_in label, with: value
      end
    end
    self
  end

  def submit!
    click_on @submit
    self
  end

private
  def fill_in_tinymce(label, options)
    element_id = find('label', text: label)[:for]
    content = options[:with]

    page.execute_script("tinyMCE.get('#{element_id}').setContent('#{content}')")
  end
end
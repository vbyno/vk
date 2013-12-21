class Admin::ShowPage < BasicPage
  def initialize(instance)
    @class_name = instance.class.name

    @url = public_send("admin_#{@class_name.underscore}_path", instance)
    @main_content = instance.title
  end

  def edit_button
    BasicButton.new(value: "Изменить #{@class_name.titleize}")
  end

  def has_instance?(instance, params = { attributes: nil })
    attributes = Array(params[:attributes])
    raise 'No attributes defined!' if attributes.empty?

    attributes.each do |attr|
      content = instance.public_send(attr)
      unless has_content? content
        raise "Expected #{self.class} to have content '#{content}'"\
              " but it was not found"
      end
    end
  end
end
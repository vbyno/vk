class Admin::IndexPage < BasicPage
  def initialize(class_obj, options = { attributes: nil })
    @class_name = class_obj.name

    @url = public_send "admin_#{@class_name.tableize}_path"
    @main_content = @class_name.tableize.titleize
  end

  def new_button
    BasicButton.new(value: "Создать #{@class_name.titleize}")
  end

  def has_instances?(*instances, options)
    attributes = Array(options[:attributes])
    raise 'No attributes defined!' if attributes.empty?

    instances.each do |instance|
      attributes.each do |attr|
        content = instance.public_send(attr)
        unless has_content? content
          raise "Expected #{self.class} to have content '#{content}'"\
                " but it was not found"
        end
      end
    end
  end
end
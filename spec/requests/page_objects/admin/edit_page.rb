class Admin::EditPage < BasicPage
  def initialize(instance, params = {})
    @class_name = instance.class.name
    @params = params

    @url = public_send("edit_admin_#{@class_name.underscore}_path", instance)
    @main_content = "Изменить #{@class_name.titleize}"
  end

  def form
    BasicForm.new(tiny_mce_textareas: @params[:tiny_mce_textareas],
                  selects: @params[:selects],
                  submit: "Update #{@class_name.titleize.humanize}")
  end
end
class Admin::NewPage < BasicPage
  def initialize(class_obj, params = {})
    @class_name = class_obj.name
    @params = params

    @url = public_send("new_admin_#{@class_name.underscore}_path")
    @main_content = "Создать #{@class_name.titleize}"
  end

  def form
    BasicForm.new(tiny_mce_textareas: @params[:tiny_mce_textareas],
                  selects: @params[:selects],
                  submit: "Create #{@class_name.titleize.humanize}")
  end
end
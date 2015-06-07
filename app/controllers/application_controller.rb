class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :locale

  def default_url_options(options = {})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    options.reverse_merge(locale.url_options)
  end

  def present(model, options = {})
    presenter_class = options.delete(:presenter_class) ||
      begin
        "#{model.class}Presenter".constantize
      rescue
        "#{model.class.base_class}Presenter".constantize
      end

    presenter_class.new(model, view_context, options)
  end

  private

  def locale
    @locale ||= Locale.new!(params[:locale])
  end
end

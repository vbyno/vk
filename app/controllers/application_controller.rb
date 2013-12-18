class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    set_locale unless @locale
    options.merge(@locale.url_options)
  end

private
  def set_locale
    @locale = Locale.new!(params[:locale])
  end
end

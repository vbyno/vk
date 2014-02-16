class Admin::BaseController < ApplicationController
  before_action :authenticate_admin!

  load_and_authorize_resource only: %i[index new edit update show delete]
  authorize_resource only: :create

  layout 'admin'

  def default_url_options(options={})
    options
  end

  def current_ability
    @current_ability ||= AdminAbility.new(current_admin)
  end

private
  def set_locale
    @locale = Locale.new!(Locale::DEFAULT)
  end
end

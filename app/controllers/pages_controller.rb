class PagesController < ApplicationController
  before_action :find_page

  def show; end

private
  def find_page
    raise NotImplementedError
  end
end

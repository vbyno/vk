class Admin::ApartmentsController < ApplicationController
  load_and_authorize_resource only: :index

  def index; end

  def show; end
end
class BasicPresenter
  include Rails.application.routes.url_helpers
  attr_reader :page

  def initialize(page)
    @page = page
  end

  def path
    raise NotImplementedError
  end
end

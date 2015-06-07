class PagePresenter < BasePresenter
  presents :page

  def path
    raise NotImplementedError
  end
end

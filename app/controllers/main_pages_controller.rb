class MainPagesController < PagesController
  def show
    @apartments = ApartmentPresenter.all(@locale)
  end

private
  def find_page
    @main_page = MainPage.available!(@locale)
  end
end
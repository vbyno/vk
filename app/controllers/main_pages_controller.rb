class MainPagesController < PagesController
  def show
    @apartments = ApartmentPresenter.all(locale, view_context)
  end

  private

  def find_page
    @main_page = MainPage.available!(locale)
  end
end
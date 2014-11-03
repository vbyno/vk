class MainPagePresenter < BasicPresenter
  def path
    page.locale_object.default? ? root_path : locale_root_path(page.locale)
  end
end

class MainPagePresenter < BasicPresenter
  def path
    if page.locale_object.default?
      root_path
    else
      locale_root_path(page.locale)
    end
  end
end

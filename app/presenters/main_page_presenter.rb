class MainPagePresenter < PagePresenter
  def path
    locale_object.default? ? h.root_path : h.locale_root_path(locale)
  end
end

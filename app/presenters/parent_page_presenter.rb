class ParentPagePresenter < BasicPresenter
  def path
    if page.locale_object.default?
      root_path(page.permalink)
    else
      locale_root_path(page.permalink, page.locale)
    end
  end
end

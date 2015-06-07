class ParentPagePresenter < PagePresenter
  def path
    if locale_object.default?
      h.parent_page_path(permalink)
    else
      h.locale_parent_page_path(locale, permalink)
    end
  end
end

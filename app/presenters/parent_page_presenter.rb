class ParentPagePresenter < BasicPresenter
  def path
    if page.locale_object.default?
      parent_page_path(page.permalink)
    else
      locale_parent_page_path(page.permalink, page.locale)
    end
  end
end

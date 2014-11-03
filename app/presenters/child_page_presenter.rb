class ChildPagePresenter < BasicPresenter
  def path
    if page.locale_object.default?
      child_page_path(page.parent_permalink, page.permalink)
    else
      locale_child_page_path(page.locale, page.parent_permalink, page.permalink)
    end
  end
end

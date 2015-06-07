class ChildPagePresenter < PagePresenter
  def path
    if locale_object.default?
      h.child_page_path(parent_permalink, permalink)
    else
      h.locale_child_page_path(locale, parent_permalink, permalink)
    end
  end
end

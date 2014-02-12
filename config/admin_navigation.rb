SimpleNavigation::Configuration.run do |navigation|
  parent_pages = ParentPage.grouped_by_locale

  navigation.items do |primary|
    Locale::ALL_S.each do |locale|
      primary.item locale, locale, admin_pages_path(locale: locale) do |parents|
        if parent_pages.has_key? locale
          parent_pages[locale].each do |parent_page|
            parents.item :"parent_page_#{parent_page.id}", parent_page.title,
                              edit_admin_page_path(parent_page) do |children|

              parent_page.child_pages.each do |child_page|
                children.item :"child_page_#{child_page.id}", child_page.title,
                                  edit_admin_page_path(child_page)
              end
            end
          end
        end
      end
    end
  end
end

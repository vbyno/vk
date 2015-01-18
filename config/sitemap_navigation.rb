SimpleNavigation::Configuration.run do |navigation|
  all_parent_pages = ParentPage.active.grouped_by_locale
  all_child_pages = ChildPage.active.group_by(&:parent_id)

  navigation.items do |primary|
    MainPage.all.each do |main_page|
      primary.item :"main_page_#{main_page.id}", main_page.title, main_page.path do |first_level|
        all_parent_pages[main_page.locale.to_sym].each do |parent_page|
          first_level.item :"parent_page_#{parent_page.id}",
                            parent_page.title,
                            parent_page.path do |second_level|
            all_child_pages[parent_page.id].each do |child_page|
              second_level.item :"child_page_#{child_page.id}", child_page.title, child_page.path
            end
          end
        end
      end
    end
  end
end


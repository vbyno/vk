class ParentPagesController < PagesController

private
  def find_page
    @parent_page = ParentPage.available!(params[:parent_permalink])
  end
end

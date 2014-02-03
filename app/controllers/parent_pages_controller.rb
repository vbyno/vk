class ParentPagesController < PagesController
private
  def find_page
    @parent_page = ParentPage.find_by(permalink: params[:parent_permalink]) ||
                     not_found
  end
end

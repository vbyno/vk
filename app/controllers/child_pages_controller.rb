class ChildPagesController < PagesController

private
  def find_page
    @page = ChildPage.find_by(permalink: params[:child_permalink])
    unless @page && @page.parent_page.permalink == params[:parent_permalink]
      not_found
    end
  end
end

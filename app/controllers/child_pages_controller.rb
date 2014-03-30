class ChildPagesController < ParentPagesController

private
  def find_page
    super
    @child_page =
      @parent_page.child_pages.available(params[:child_permalink]) || not_found
  end
end

class Admin::PagesController < Admin::BaseController
  def new; end

  def create
    @page = Page.create(page_params)
  end

private
  def page_params
    params.require(:page).permit(
      :id, :type, :parent_id, :permalink, :locale, :content, :active,
      :seo_title, :seo_description, :seo_keywords
    )
  end
end

class Admin::PagesController < Admin::BaseController
  def index; end
  def new; end

  def create
    @page = Page.new(page_params)
    if @page.save
      redirect_to admin_pages_path, notice: t('.success')
    else
      render :new
    end
  end

  def edit; end

  def update
    if @page.update_attributes(page_params)
      redirect_to admin_pages_path, notice: t('.success')
    else
      render :edit
    end
  end

private
  def page_params
    params.require(:page).permit(
      :id, :type, :parent_id, :permalink, :locale, :content, :active,
      :priority, :seo_title, :seo_description, :seo_keywords
    )
  end
end

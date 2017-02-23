class Admin::PagesController < Admin::AdminController
  def index
    @pages = ::Page.all
  end

  def edit
    @page = ::Page.find(params[:id])
  end

  def update
    @page = ::Page.new(page_params)
    if @page.save
      redirect_to action: :index
    else
      render :index
    end
  end

  private
    def page_params
      params.require(:title).permit(:keywords, :description, :content, :background_menu)
    end

end

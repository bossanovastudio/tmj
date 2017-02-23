class Admin::PagesController < Admin::AdminController
  before_action :load_page, except: [:index]
  def index
    @pages = ::Page.all
  end

  def edit
  end

  def update
    @page.assign_attributes page_params
    if @page.save
      redirect_to action: :index
    else
      render :index
    end
  end

  private
    def page_params
      params.require(:page).permit(:title, :keywords, :description, :content, :background_menu)
    end

    def load_page
      @page = ::Page.find(params[:id])
    end

end

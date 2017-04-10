class Admin::PagesController < Admin::AdminController
  before_action :load_page, except: [:index, :presigned_url]
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

  def presigned_url
    s3 = Aws::S3::Resource.new(region:'sa-east-1')
    obj = s3.bucket(ENV['AWS_S3_BUCKET']).object("pages_assets/#{SecureRandom.uuid}")
    render json: { presigned_url: obj.presigned_url(:put, acl: 'public-read') }
  end

  private
    def page_params
      params.require(:page).permit(:title, :keywords, :description, :content, :background_menu, :background_page)
    end

    def load_page
      @page = ::Page.find(params[:id])
    end

end

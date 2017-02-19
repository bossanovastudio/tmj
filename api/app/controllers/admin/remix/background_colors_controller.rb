class Admin::Remix::BackgroundColorsController < Admin::AdminController
  # before_action :authenticate_user!
  before_action :set_background, only: [:edit, :update, :destroy]

  def index
    @backgrounds = ::Remix::BackgroundColor.all
  end

  def new
    @background = ::Remix::BackgroundColor.new
  end

  def create
    @background = ::Remix::BackgroundColor.new(background_params)
    if @background.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @background.update(background_params)
      redirect_to action: :index, notice: 'BackgroundColor was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @background.destroy
    redirect_to action: :index, notice: 'Card was successfully destroyed.'
  end


  private
    def background_params
      params.require(:remix_background_color).permit(:color)
    end

    def set_background
      @background = ::Remix::BackgroundColor.find(params[:id])
    end
end

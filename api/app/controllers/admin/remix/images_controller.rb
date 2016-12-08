class Admin::Remix::ImagesController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_image, only: [:destroy]

  def index
    @category = ::Remix::Category.find(params[:category_id])
    @images = @category.images
  end

  def new
    @category = ::Remix::Category.find(params[:category_id])
    @image = @category.images.new
  end

  def create
    @category = ::Remix::Category.find(params[:category_id])
    @image = @category.images.new(image_params)
    if @image.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def destroy
    @image.destroy
    redirect_to action: :index, notice: 'Image was successfully destroyed.'
  end


  private
    def image_params
      params.require(:remix_image).permit(:image)
    end

    def set_image
      @image = ::Remix::Image.find(params[:id])
    end
end

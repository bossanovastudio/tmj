class Admin::Remix::StickersController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_sticker, only: [:destroy]

  def index
    @stickers = ::Remix::Sticker.all
  end

  def new
    @sticker = ::Remix::Sticker.new
  end

  def create
    @sticker = ::Remix::Sticker.new(sticker_params)
    if @sticker.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def destroy
    @sticker.destroy
    redirect_to action: :index, notice: 'Sticker was successfully destroyed.'
  end


  private
    def sticker_params
      params.require(:remix_sticker).permit(:image, :kind)
    end

    def set_sticker
      @sticker = ::Remix::Sticker.find(params[:id])
    end
end

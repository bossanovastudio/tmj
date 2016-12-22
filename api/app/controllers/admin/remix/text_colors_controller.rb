class Admin::Remix::TextColorsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_text, only: [:edit, :update, :destroy]

  def index
    @text_colors = ::Remix::TextColor.all
  end

  def new
    @text_color = ::Remix::TextColor.new
  end

  def create
    @text_color = ::Remix::TextColor.new(text_params)
    if @text_color.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @text_color.update(text_params)
      redirect_to action: :index, notice: 'TextColor was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @text_color.destroy
    redirect_to action: :index, notice: 'Card was successfully destroyed.'
  end


  private
    def text_params
      params.require(:remix_text_color).permit(:background, :foreground)
    end

    def set_text
      @text_color = ::Remix::TextColor.find(params[:id])
    end
end

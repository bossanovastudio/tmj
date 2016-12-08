class RemixController < ApplicationController
  def categories
    @categories = Remix::Category.order(:name)
  end

  def images
    category = Remix::Category.find(params[:id])
    @images = category.images.order(id: :desc)
  end

  def backgrounds
    @backgrounds = Remix::BackgroundColor.order(id: :desc)
  end

  def text_colors
    @colors = Remix::TextColor.order(id: :desc)
  end

  def stickers
    @stickers = Remix::Sticker.where(type: params[:type]).order(id: :desc)
  end

  def create

  end
end

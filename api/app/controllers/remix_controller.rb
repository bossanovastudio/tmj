class RemixController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  layout 'remix'

  def index
    @images = Remix::UserImage.where(user_id: current_user.id).order(id: :desc)
  end

  def show
    img = Remix::UserImage.find(params[:id])
    redirect_to img.image_url
  end

  def detail
    img = Remix::UserImage.find(params[:id])
    @img = img.image_url
    # redirect_to img.image_url
  end
end

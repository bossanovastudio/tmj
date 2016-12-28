class RemixController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  layout 'remix'

  def index
    @images = Remix::UserImage.where(user_id: current_user.id).order(id: :desc)
  end

  def show
    img = Remix::UserImage.find_by!(uid: params[:uid])
    redirect_to img.image_url
  end

  def detail
    img = Remix::UserImage.find_by!(uid: params[:uid])
    @img = img.image_url
    @id = params[:uid]
    @url = request.original_url
  end
end

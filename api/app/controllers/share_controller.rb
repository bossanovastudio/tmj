class ShareController < ApplicationController
  layout false
  def card
    @card = Card.find_by_id!(params[:id])
  end

  def profile
    @profile = User.find_by!(username: params[:username])
  end

  def remix
    @remix = Remix::UserImage.find_by!(uid: params[:uid])
  end
end

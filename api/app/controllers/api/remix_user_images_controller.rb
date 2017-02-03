class Api::RemixUserImagesController < ApplicationController
  def show
    @image = Remix::UserImage.find_by!(uid: params[:id])
  end
end

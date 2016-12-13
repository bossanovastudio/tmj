class Api::VideosController < ApplicationController
  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(video_params)

    if @video.save
      render :show, status: :created
    else
      render json: @video.errors, status: :unprocessable_entity
    end
  end
  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.permit(:url, :origin, :thumbnail, :remote_thumbnail_url)
    end
end

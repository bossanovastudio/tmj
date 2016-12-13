class Api::ImagesController < ApplicationController
  # POST /images
  # POST /images.json
  def create
    @image = Image.new(image_params)

    if @image.save
      render :show, status: :created
    else
      render json: @image.errors, status: :unprocessable_entity
    end
  end
  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.permit(:file, :remote_file_url)
    end
end

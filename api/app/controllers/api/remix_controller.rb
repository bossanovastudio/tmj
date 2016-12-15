class Api::RemixController < ApplicationController
  before_action :authenticate_user!
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
    @stickers = Remix::Sticker.where(kind: params.fetch(:kind, :speech_balloon).to_sym).order(id: :desc)
  end

  def delete
    item = Remix::UserImage.where(id: params[:id], user_id: current_user.id)
    item.destroy_all
  end

  def create
    steps = params[:elements].keys.sort.collect { |k| params[:elements][k].to_unsafe_h.symbolize_keys }
    gen = ::RemixGenerator::RemixGenerator.new(steps)
    img = gen.process
    puts img
    puts current_user
    image = Remix::UserImage.new(image: img, user: current_user)
    if image.save
      render json: { share_url: remix_image_url(id: image.id), id: image.id }
    else
      render json: image.errors, status: :unprocessable_entity
    end
    # img.unlink
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      the_params = params.permit(:image)
      the_params[:image] = change_img_params(the_params[:image]) unless the_params[:image].nil?
      the_params
    end

    def change_img_params(img)
      begin
        Base64.decode64(img) #To check if thats a base64 string
        if img
          img = file_decode(img.split(',')[1], "image.png")
        end
      rescue Exception => e
        puts e
        img
      end
    end

    def file_decode(base, filename)
      file = Tempfile.new([file_base_name(filename), file_extn_name(filename)])
      file.binmode
      file.write(Base64.decode64(base))
      file.close
      file
    end

    def file_base_name(file_name)
      File.basename(file_name, file_extn_name(file_name))
    end

    def file_extn_name(file_name)
      File.extname(file_name)
  end
end

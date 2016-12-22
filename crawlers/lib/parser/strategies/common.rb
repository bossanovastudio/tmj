module Crawlers::Parser
  module Common
    def image(url)
      @image = Image.new
      @image.remote_file_url = url

      if @image.save
        @image.id
      else
        $logger.error('Error saving image: #{@image.inspect}')
      end
    end

    def video(url, origin, thumbnail)
      @video = Video.new
      @video.url = url
      @video.origin = origin
      @video.remote_thumbnail_url = thumbnail

      if @video.save
        @video.id
      else
        $logger.error('Error saving video: #{@video.inspect}')
      end
    end
  end
end

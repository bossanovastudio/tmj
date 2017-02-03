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

    def extract_remix_data_from_url(url)
      pat = /tmjofilme.com.br\/remix\/detalhe\/([a-f0-9]{40})/i.freeze
      return nil unless url =~ pat
      begin
        data = pat.match(url)[1]
        return RemixUserImage.find(data).id
      rescue Exception => e
        puts e
        return nil
      end
    end
  end
end

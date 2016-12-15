require 'prawn'
require 'prawn/measurement_extensions'
require 'tempfile'
require 'open-uri'
require 'rmagick'

module RemixGenerator
  class TextBoxCallback
    def initialize(options)
      @color = options[:color]
      @document = options[:document]
    end

    def render_behind(fragment)
      return if @color == 'transparent'
      original_color = @document.fill_color
      puts fragment.top_left
      @document.fill_color = @color
      @document.fill_rectangle([fragment.top_left[0] - 3, fragment.top_left[1] + 5], fragment.width + 6, fragment.height + 10)
      @document.fill_color = original_color
    end
  end

  class RemixGenerator
    def initialize(steps)
      @steps = steps
    end

    def process
      p_size = [132.820833333.mm, 132.820833333.mm]
      steps = @steps
      garbage = []
      doc = Prawn::Document.new(page_size: p_size, :margin => [0,0,0,0]) do
        bounding_box [0, p_size.first], width: p_size.first, height: p_size.first do
          steps.each do |step|
            case step[:type]
            when 'background'
              fill_color step[:color]
              fill_rectangle [0, p_size.first], p_size.first, p_size.first
              img = RemixGenerator.imgop(step[:src], garbage) do |img|
                case step[:effect]
                when 'sepia'
                  puts 'applying sepiatone'
                  img = img.sepiatone
                when 'grayscale'
                  puts 'applying grayscale'
                  img = img.quantize(256, Magick::GRAYColorspace)
                when 'filter_2'
                  puts 'applying filter_2'
                  img = img.sepiatone
                  img = img.modulate(1, 1, 2)
                when 'filter_3'
                  puts 'applying filter_3'
                  img = img.contrast true
                  img = img.sepiatone
                  img = img.modulate(1, 1.8, 1)
                end
                img
              end
              image img, at: RemixGenerator.px_to_mm([0, 502]), height: p_size.first, width: p_size.first
            when 'image'
              position = RemixGenerator.px_to_mm(step[:position])
              width = step[:width].to_i
              height = step[:height].to_i
              img = RemixGenerator.imgop(step[:src], garbage) do |img|
                img.background_color = "#0000"
                img.resize! width, height
                img.rotate! step.fetch(:rotation, "0").to_i
                width = RemixGenerator.px_to_mm(img.columns)
                height = RemixGenerator.px_to_mm(img.rows)
                img
              end
              image img, at: position, width: width, height: height
            when 'text'
              width = RemixGenerator.px_to_mm(step[:width].to_i + 6)
              height = RemixGenerator.px_to_mm(step[:height].to_i + 10)
              position = RemixGenerator.px_to_mm([step[:position][0].to_i + 6, step[:position][1].to_i - 5])
              cb = TextBoxCallback.new(color: step[:bg], document: self)
              font './vendor/assets/fonts/KomikaTitle-webfont.ttf' do
                formatted_text_box [{ text: step[:content], size: RemixGenerator.px_to_mm(step[:size]), color: step[:fg], callback: cb }], at: position, width: width, height: height
              end
            end
          end
        end
      end

      pdf_tmp = Tempfile.new(['tmj-remix', '.pdf'])
      png_tmp = Tempfile.new(['tmj-remix', '.png'])

      doc.render_file pdf_tmp.path
      pdf_page = Magick::Image.read(pdf_tmp.path)[0]
      pdf_page.scale(502, 502)
      pdf_page.write(png_tmp.path) { self.quality = 90 }
      garbage.each { |f| f.unlink }
      png_tmp
    end

    def self.px_to_mm(px)
      if px.kind_of? Array
        px.collect { |x| px_to_mm(x) }
      else
        (px.to_i * 0.264583333).mm
      end
    end

    def self.imgop(path, garbage)
      img = Magick::ImageList.new(path)
      ret = yield(img)
      # img = ret if ret.kind_of? Magick::ImageList
      img = ret
      tmp = Tempfile.new
      img.write(tmp.path)
      garbage << tmp
      tmp.path
    end
  end
end

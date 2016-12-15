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
    def self.test
      inst = RemixGenerator.new([
        { type: 'background', color: 'cc0000', src: 'http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/3/foto-1.png' },
        { type: 'image', src: 'http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/8/balao-5_3x.png', position: [10, 10], width: 222, height: 207, rotation: 90 },
        { type: 'text', content: 'qwerty', size: 20, position: [100, 100], bg: '000000', fg: 'FFFFFF' }
      ])
      inst.process
    end

    def initialize(steps)
      @steps = steps
      @garbage = []
      @canvas = Magick::ImageList.new
      @canvas.new_image(502, 502, Magick::HatchFill.new('white', 'gray90'))
    end

    def process
      @steps.each do |step|
        case step[:type]
        when 'background'
          @canvas << Magick::Image.new(502, 502) { self.background_color = "##{step[:color]}" }
          @canvas << imgop(step[:src]) do |img|
            img.resize_to_fit!(502, 502)
            case step[:effect]
            when 'sepia'
              img.sepiatone
            when 'grayscale'
              img.quantize(256, Magick::GRAYColorspace)
            when 'filter_2'
              img = img.sepiatone
              img.modulate(1, 1, 2)
            when 'filter_3'
              img = img.contrast true
              img = img.sepiatone
              img.modulate(1, 1.8, 1)
            else
              img
            end
          end
        when 'image'
          tmp = Magick::Image.new(502, 502) { self.background_color = '#0000' }
          position = step[:position].collect &:to_i
          width = step[:width].to_i
          height = step[:height].to_i
          rotation = step[:rotation].to_i
          ops = imgop(step[:src]) do |img|
            img.background_color = '#0000'
            img.resize! width, height
            img.rotate! rotation
          end
          @canvas << tmp.composite(ops, position[0], position[1], Magick::OverCompositeOp)
        when 'text'
          position = step[:position].collect &:to_i
          background = step[:bg] == 'transparent' ? '#0000' : "##{step[:bg]}"
          tmp = Magick::Image.new(502, 502) { self.background_color = '#0000' }
          text = Magick::Draw.new
          text.font = './vendor/assets/fonts/KomikaTitle-webfont.ttf'
          text.fill = "##{step[:fg]}"
          text.undercolor = background
          text.pointsize = step[:size].to_i
          text.gravity = Magick::NorthWestGravity
          size_info = text.get_multiline_type_metrics(step[:content])
          rect_height = size_info.height
          rect_width = size_info.width
          if background != '#0000'
            rect_height += 12
            rect_width += 20

            gc = Magick::Draw.new
            gc.fill = background
            gc.rectangle position[0], position[1], position[0] + rect_width, position[1] + rect_height
            gc.draw(tmp)
          end
          text.annotate(tmp, size_info.width, size_info.height, position[0] + 10, position[1] + 6, step[:content])
          @canvas << tmp
        end
      end
      t = Tempfile.new(['test', '.png'])
      @canvas.flatten_images.write(t.path)
      t
    end

    def imgop(path)
      img = Magick::ImageList.new(path).first
      ret = yield(img)
      ret
    end
  end
end

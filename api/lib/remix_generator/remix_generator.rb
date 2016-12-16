require 'tempfile'
require 'open-uri'
require 'rmagick'

module RemixGenerator
  class RemixGenerator
    def self.test
      inst = RemixGenerator.new({
        steps: [
          { type: 'background', color: 'cc0000', src: 'http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/3/foto-1.png', pattern: 'http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/3/foto-1.png' },
          { type: 'image', src: 'http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/8/balao-5_3x.png', position: [10, 10], width: 222, height: 207, rotation: 90 },
          { type: 'text', content: 'qwerty', size: 20, position: [100, 100], bg: '000000', fg: 'FFFFFF' }
        ]
      })
      inst.process
    end

    def initialize(options = {})
      @steps = options[:steps]
      @garbage = []
      @canvas = Magick::ImageList.new
      @canvas_side = options.fetch(:canvas_side, 502)
      @canvas.new_image(@canvas_side, @canvas_side, Magick::HatchFill.new('white', 'gray90'))
    end

    def process
      @steps.each do |step|
        case step[:type]
        when 'background'
          @canvas << Magick::Image.new(@canvas_side, @canvas_side) { self.background_color = "##{step[:color]}" }
          if step[:custom]
            bin_data = step[:src].split(',')[1]
            blob = Base64.decode64(bin_data)
            step[:src] = Magick::Image.from_blob(blob).first
          end
          if step.key? :pattern
            @canvas << imgop(step[:pattern]) { |img| img.resize_to_fit!(@canvas_side, @canvas_side) }
          end
          @canvas << imgop(step[:src]) do |img|
            img.resize_to_fit!(@canvas_side, @canvas_side)
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
          tmp = Magick::Image.new(@canvas_side, @canvas_side) { self.background_color = '#0000' }
          position = step[:position].collect &:to_i
          width = step[:width].to_i
          height = step[:height].to_i
          rotation = step[:rotation].to_i
          ops = imgop(step[:src]) do |img|
            img.background_color = '#0000'
            img.rotate! rotation
            img.resize! width, height
          end
          @canvas << tmp.composite(ops, position[0], position[1], Magick::OverCompositeOp)
        when 'text'
          position = step[:position].collect &:to_i
          background = step[:bg] == 'transparent' ? '#0000' : "##{step[:bg]}"
          tmp = Magick::Image.new(@canvas_side, @canvas_side) { self.background_color = '#0000' }
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
      img = Magick::ImageList.new(path).first if path.kind_of? String
      img = path if path.kind_of? Magick::Image
      img = yield(img) if block_given?
      img
    end
  end
end

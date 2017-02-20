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
      @images = options.fetch(:images, [])
    end

    def generate_common
      @steps.each do |step|
        case step[:type]
        when 'background'
          @canvas << Magick::Image.new(@canvas_side, @canvas_side) { self.background_color = "##{step[:color]}" }
          if step.key? :pattern
            @canvas << imgop(step[:pattern]) { |img| img.resize_to_fit!(@canvas_side, @canvas_side) }
          end
        when 'image'
          tmp = Magick::Image.new(@canvas_side, @canvas_side) { self.background_color = '#0000' }
          position = step[:position].collect &:to_i
          width = step[:width].to_i
          height = step[:height].to_i
          rotation = step[:rotation].to_i
          src = step[:src]
          if src.length > 500
            bin_data = src.split(',')[1]
            blob = Base64.decode64(bin_data)
            src = Magick::Image.from_blob(blob).first
          end
          ops = imgop(src) do |img|
            img.background_color = '#0000'
            img.rotate! rotation
            img.resize! width, height
          end
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
          content = adjust_text(step[:content], rect_width, step[:size].to_i)
          text.annotate(tmp, size_info.width, size_info.height, position[0] + 10, position[1] + 6, content)
          @canvas << tmp
        end
      end
      t = Tempfile.new(['remix', '.png'])
      @canvas.flatten_images.write(t.path)
      t
    end

    def generate_strip
      width = 502
      height = 502
      margin = 15
      @images = Remix::UserImage.where(id: @images)

      @canvas = Magick::ImageList.new

      if @images.count < 4
        pic_height = (height - (margin * 2)) / @images.count
        pic_width = (width - (margin * 2) - ((@images.count - 1) * margin)) / @images.count
        pos = margin
        @canvas.new_image(width, pic_height + margin * 2, Magick::HatchFill.new('white', 'gray90'))
        @canvas << Magick::Image.new(width, pic_height + margin * 2) { self.background_color = '#FFF' }

        @images.each do |img|
          tmp = Magick::Image.new(width, height) { self.background_color = '#0000' }
          ops = imgop(img.image_url) do |img|
            img.background_color = '#0000'
            img.resize!(pic_width, pic_height)
            gc = Magick::Draw.new
            gc.fill = '#0000'
            gc.stroke = '#000'
            gc.rectangle 0, 0, pic_width - 1, pic_height - 1
            gc.draw img
            img
          end
          @canvas << tmp.composite(ops, pos, margin, Magick::OverCompositeOp)
          pos += pic_width + 15
        end
      else
        pic_height = (height - (margin * 3)) / (@images.count / 2)
        pic_width =  (width -  (margin * 2) - ((@images.count - 2) * margin)) / (@images.count / 2)
        x = margin
        y = margin
        height = pic_height * 2 + margin * 3
        width = pic_width * 2 + margin * 3

        @canvas.new_image(width, height, Magick::HatchFill.new('white', 'gray90'))
        @canvas << Magick::Image.new(width, height + margin * 2) { self.background_color = '#FFF' }

        @images.each do |img|
          tmp = Magick::Image.new(width, height) { self.background_color = '#0000' }
          ops = imgop(img.image_url) do |img|
            img.background_color = '#0000'
            img.resize!(pic_width, pic_height)
            gc = Magick::Draw.new
            gc.fill = '#0000'
            gc.stroke = '#000'
            gc.rectangle 0, 0, pic_width - 1, pic_height - 1
            gc.draw img
            img
          end
          @canvas << tmp.composite(ops, x, y, Magick::OverCompositeOp)

          x += pic_width + margin
          if x + margin * 2.5 >= width
            y += pic_height + margin
            x = margin
          end
        end
      end

      t = Tempfile.new(['strip', '.png'])
      @canvas.flatten_images.write(t.path)
      t
    end



    def imgop(path)
      img = Magick::ImageList.new(path).first if path.kind_of? String
      img = path if path.kind_of? Magick::Image
      img = yield(img) if block_given?
      img
    end

    def text_fit_width?(options={})
      width = options[:width]
      size = options[:text_size]
      contents = options[:content]

      tmp_image = Magick::Image.new(width, 500)
      drawing = Magick::Draw.new
      drawing.annotate(tmp_image, 0, 0, 0, 0, contents) do |txt|
        txt.gravity = Magick::NorthGravity
        txt.pointsize = size
        txt.fill = '#ffffff'
        txt.font = './vendor/assets/fonts/KomikaTitle-webfont.ttf'
      end
      metrics = drawing.get_multiline_type_metrics(tmp_image, contents)
      return metrics.width < width
    end

    def adjust_text(text, width, size)
      sep = ' '
      line = ''
      if !text_fit_width?(width: width, text_size: size, content: text) && text.include?(sep)
        i = 0
        text.split(sep).each do |w|
          if i == 0
            tmp_line = line + w
          else
            tmp_line = line + sep + w
          end

          if text_fit_width?(content: tmp_line, width: width, text_size: size)
            line += separator unless i == 0
            line += w
          else
            line += '\n' unless i == 0
            line += w
          end
          i += 1
        end
        text = line
      end
      text
    end

  end
end

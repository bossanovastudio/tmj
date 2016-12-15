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
      doc = Prawn::Document.new(page_size: p_size, :margin => [0,0,0,0]) do
        bounding_box [0, p_size.first], width: p_size.first, height: p_size.first do
          steps.each do |step|
            case step[:type]
            when 'background'
              fill_color step[:color]
              fill_rectangle [0, p_size.first], p_size.first, p_size.first
              image open(step[:src]), at: RemixGenerator.px_to_mm([0, 502]), height: p_size.first, width: p_size.first
            when 'image'
              width = RemixGenerator.px_to_mm(step[:width])
              height = RemixGenerator.px_to_mm(step[:height])
              position = RemixGenerator.px_to_mm(step[:position])

              rotate step.fetch(:rotate, 0), origin: [position[0] + width, position[1] + height].collect { |x| x / 2.0 } do
                image open(step[:src]), at: position, width: width, height: height
              end
            when 'text'
              width = RemixGenerator.px_to_mm(step[:width])
              height = RemixGenerator.px_to_mm(step[:height])
              cb = TextBoxCallback.new(color: step[:bg], document: self)
              font './vendor/assets/fonts/KomikaTitle-webfont.ttf' do
                formatted_text_box [{ text: step[:content], size: RemixGenerator.px_to_mm(step[:size]), color: step[:fg], callback: cb }], at: RemixGenerator.px_to_mm(step[:position]), width: width, height: height
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
      # pdf_tmp.unlink
      png_tmp
    end

    def self.px_to_mm(px)
      if px.kind_of? Array
        px.collect { |x| px_to_mm(x) }
      else
        (px * 0.264583333).mm
      end
    end
  end
end

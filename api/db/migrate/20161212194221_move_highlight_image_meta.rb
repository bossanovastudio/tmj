class MoveHighlightImageMeta < ActiveRecord::Migration[5.0]
  def up
    Highlight.all.each do |h|
      unless h.media.nil?
        if h.media.class == Image
          h.desktop_image_id = h.media_id
        end
      end


      unless h.mobile_media.nil?
        if h.mobile_media.class == Image
          h.mobile_image_id = h.mobile_media_id
        end
      end
      h.save!
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

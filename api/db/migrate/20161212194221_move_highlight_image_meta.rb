class MoveHighlightImageMeta < ActiveRecord::Migration[5.0]
  def up
    Highlight.all.each do |h|
      unless h.media_id.nil?
        h.desktop_image_id = h.media_id if h.media_type == "Image"
      end


      unless h.mobile_media_id.nil?
        h.mobile_image_id = h.mobile_media_id if h.mobile_media_type == "Image"
      end
      h.save!
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

class AddImagesToHighlight < ActiveRecord::Migration[5.0]
  def change
    add_reference :highlights, :desktop_image, foreign_key: { to_table: :images }
    add_reference :highlights, :mobile_image, foreign_key: { to_table: :images }
  end
end

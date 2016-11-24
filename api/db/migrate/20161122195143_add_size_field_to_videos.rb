class AddSizeFieldToVideos < ActiveRecord::Migration[5.0]
  def change
    add_column :videos, :width, :integer, null: false, default: 1
    add_column :videos, :height, :integer, null: false, default: 1
  end
end

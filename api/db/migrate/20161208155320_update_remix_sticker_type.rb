class UpdateRemixStickerType < ActiveRecord::Migration[5.0]
  def change
    rename_column :remix_stickers, :type, :kind
  end
end

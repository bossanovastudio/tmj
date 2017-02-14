class AddStripFlagToRemixUserImage < ActiveRecord::Migration[5.0]
  def change
    add_column :remix_user_images, :is_strip, :boolean, default: false
  end
end

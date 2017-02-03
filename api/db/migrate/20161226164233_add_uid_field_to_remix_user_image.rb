class AddUidFieldToRemixUserImage < ActiveRecord::Migration[5.0]
  def change
    add_column :remix_user_images, :uid, :string
  end
end

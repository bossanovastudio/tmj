class AddRemixImageIdToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :remix_image_id, :integer
  end
end

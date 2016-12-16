class CreateRemixStickers < ActiveRecord::Migration[5.0]
  def change
    create_table :remix_stickers do |t|
      t.string :image
      t.integer :type

      t.timestamps
    end
  end
end

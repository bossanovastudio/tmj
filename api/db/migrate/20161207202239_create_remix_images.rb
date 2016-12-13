class CreateRemixImages < ActiveRecord::Migration[5.0]
  def change
    create_table :remix_images do |t|
      t.references :remix_category, foreign_key: true
      t.string :image

      t.timestamps
    end
  end
end

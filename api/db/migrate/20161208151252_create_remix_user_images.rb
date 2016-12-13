class CreateRemixUserImages < ActiveRecord::Migration[5.0]
  def change
    create_table :remix_user_images do |t|
      t.references :user, foreign_key: true
      t.string :image

      t.timestamps
    end
  end
end

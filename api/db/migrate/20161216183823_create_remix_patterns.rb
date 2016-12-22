class CreateRemixPatterns < ActiveRecord::Migration[5.0]
  def change
    create_table :remix_patterns do |t|
      t.string :image

      t.timestamps
    end
  end
end

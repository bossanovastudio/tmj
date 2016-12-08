class CreateRemixTextColors < ActiveRecord::Migration[5.0]
  def change
    create_table :remix_text_colors do |t|
      t.string :foreground
      t.string :background

      t.timestamps
    end
  end
end

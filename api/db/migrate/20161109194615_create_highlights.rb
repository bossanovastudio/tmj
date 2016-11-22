class CreateHighlights < ActiveRecord::Migration[5.0]
  def change
    create_table :highlights do |t|
      t.text :content
      t.references :media, polymorphic: true
      t.datetime :posted_at

      t.timestamps
    end
  end
end

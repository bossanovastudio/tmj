class CreateCrawledPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :crawled_posts do |t|
      t.integer :social_media
      t.integer :social_uuid
      t.jsonb   :data

      t.timestamps
    end

    add_index :crawled_posts, :data, using: :gin
  end
end

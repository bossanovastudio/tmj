class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.integer :user_id
      t.integer :origin
      t.text :content
      t.references :media, polymorphic: true
      t.datetime :posted_at

      t.timestamps
    end
  end
end

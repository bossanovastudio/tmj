class CreateRemixCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :remix_categories do |t|
      t.string :cover
      t.string :name

      t.timestamps
    end
  end
end

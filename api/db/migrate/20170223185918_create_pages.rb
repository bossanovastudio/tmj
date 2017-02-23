class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
      t.string :title
      t.string :keywords
      t.string :description
      t.text :content
      t.string :background_menu

      t.timestamps
    end
  end
end

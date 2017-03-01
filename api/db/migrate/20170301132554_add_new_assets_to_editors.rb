class AddNewAssetsToEditors < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :like_button, :string
    add_column :users, :like_button_hover, :string
  end
end

class AddEditorFieldsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :editor_color,                 :string, default: nil
    add_column :users, :editor_icon,                  :string, default: nil
    add_column :users, :editor_desktop_background,    :string, default: nil
    add_column :users, :editor_mobile_background,     :string, default: nil
    add_column :users, :editor_menu_background,       :string, default: nil
    add_column :users, :editor_recommendation_ribbon, :string, default: nil
    add_column :users, :editor_avatar_hover,          :string, default: nil
  end
end

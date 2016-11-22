class AddSizeFieldToHighlights < ActiveRecord::Migration[5.0]
  def change
    add_column :highlights, :size, :integer, default: 1
  end
end

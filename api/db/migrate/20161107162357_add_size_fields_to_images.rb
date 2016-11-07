class AddSizeFieldsToImages < ActiveRecord::Migration[5.0]
  def change
    add_column :images, :width, :integer, null: false, default: 1
    add_column :images, :height, :integer, null: false, default: 1
  end
end

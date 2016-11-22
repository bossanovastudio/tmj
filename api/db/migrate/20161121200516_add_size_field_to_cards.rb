class AddSizeFieldToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :size, :integer, default: 1
  end
end

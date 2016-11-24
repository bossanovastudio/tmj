class AddStatusFieldToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :status, :integer, default: 1
  end
end

class AddStatusFieldToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :status, :integer
  end
end

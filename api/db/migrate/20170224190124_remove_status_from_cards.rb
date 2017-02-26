class RemoveStatusFromCards < ActiveRecord::Migration[5.0]
  def change
    remove_column :cards, :status, :integer
  end
end

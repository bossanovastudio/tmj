class RemoveUserIdFieldFromCards < ActiveRecord::Migration[5.0]
  def change
    remove_column :cards, :user_id, :integer
  end
end

class ChangeRoleDefaultValueOnUsers < ActiveRecord::Migration[5.0]
  def up
    change_column_default :users, :role, 1
  end
end

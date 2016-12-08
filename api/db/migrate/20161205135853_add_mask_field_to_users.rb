class AddMaskFieldToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :mask, :string
  end
end
